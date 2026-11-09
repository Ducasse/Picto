# Packaging a Pharo application for macOS and Windows

A Pharo application usually lives in an image: you open Pharo, load the code, and run a script.
Players expect something else: a `Picto.app` they drag into `Applications`, or an installer they double-click.
[PharoApplicationGenerator](https://github.com/tesonep/PharoApplicationGenerator) bridges the two.
From a loaded image it generates a native launcher, an application bundle and an installer.

This document walks through every step on a real example: [Picto](https://github.com/Ducasse/Picto),
a small nonogram game written with Bloc and Toplo, packaged for Pharo 14.
At the end, each push to `master` publishes a macOS DMG and a Windows MSI.
[Takuzu](https://github.com/tesonep/Takuzu) is the original example of this approach, on Pharo 13.

## How it works

PharoApplicationGenerator works in four steps:

1. Load your application in a Pharo image.
2. Load PharoApplicationGenerator in the same image.
3. Ask a generator (`AppGeneratorOSXGenerator` or `AppGeneratorWindowsGenerator`) to write a build project:
   CMake files, a small C launcher, metadata (`Info.plist` or Windows resources) and a build script.
4. Run the build script. It downloads a headless Pharo VM, compiles the launcher, copies the image next to it,
   and produces the installer.

When the player starts the application, the launcher starts the VM on the embedded image with two arguments:
the name of your command line entry point, and `--embedded`.
So the one thing your application must provide is a **command line entry point** that opens its windows.
Bloc, Spec-GTK or SDL applications open their own OS windows: no Pharo world window is shown.

## 1. Give the application its own package and group

Keep the packaging code out of the game: players who load the game in their image do not need
PharoApplicationGenerator. Picto adds a `Nonogram-App` package (and `Nonogram-App-Tests`) and an `App` group
to its baseline. The default group does not change.

```smalltalk
BaselineOfNonogram >> baseline: spec
	<baseline>
	spec for: #common do: [
		spec baseline: 'Toplo' with: [ spec repository: 'github://pharo-graphics/Toplo:Pharo14/src' ].
		spec
			baseline: 'ApplicationGenerator'
			with: [
				spec
					repository: 'github://tesonep/PharoApplicationGenerator:master/src';
					loads: #( 'Core' 'Support' ) ].
		spec baseline: 'ObjCBridge' with: [ spec repository: 'github://tesonep/objcbridge:master/src' ].
		spec
			package: 'Nonogram';
			package: 'Nonogram-UI' with: [ spec requires: #( 'Nonogram' 'Toplo' ) ];
			package: 'Nonogram-Tests' with: [ spec requires: #( 'Nonogram-UI' ) ];
			package: 'Nonogram-App' with: [ spec requires: #( 'Nonogram-UI' 'ApplicationGenerator' 'ObjCBridge' ) ];
			package: 'Nonogram-App-Tests' with: [ spec requires: #( 'Nonogram-App' ) ].
		spec
			group: 'Core' with: #( 'Nonogram' );
			group: 'UI' with: #( 'Nonogram-UI' );
			group: 'Tests' with: #( 'Nonogram-Tests' );
			group: 'App' with: #( 'Nonogram-App' 'Nonogram-App-Tests' );
			group: 'default' with: #( 'Core' 'UI' 'Tests' ) ]
```

- `ApplicationGenerator` brings the generators (`Core`) and the runtime support used inside the packaged image
  (`Support`: error handlers, window title and icon). The `AppGenerator-Example` package is not needed.
- `ObjCBridge` is only needed for a native macOS menu bar (section 3).

The `Nonogram-App` package holds three classes:

| Class | Role |
|---|---|
| `NGPictoCommand` | the `picto` command line entry point |
| `NGApplication` | the metadata, the packaging, and the launch of the game |
| `NGAppErrorHandler` | unhandled errors reported in a message box (section 4) |
| extensions | three methods Pharo 14 removed and PharoApplicationGenerator or ObjCBridge still send (sections 3 and 4) |

## 2. Write the command line entry point

### In Pharo 14: a Clap command

Up to Pharo 13, the entry point was a subclass of `CommandLineHandler` with a class-side `commandName`
(that is what Takuzu does). **In Pharo 14 this does not work anymore**: the command line is handled by Clap,
and only commands declared with a `<commandline>` pragma are found. A `CommandLineHandler` subclass loads
without complaint but is never called.

So Picto declares a Clap command:

```smalltalk
ClapPharoApplication << #NGPictoCommand
	package: 'Nonogram-App'

NGPictoCommand class >> commandName
	^ 'picto'

NGPictoCommand class >> commandSpecification
	<commandline>
	^ (ClapCommandSpec id: self commandName asSymbol)
		description: 'Launch Picto, a simple nonogram game developed in Pharo';
		commandClass: self;
		addHelp;
		addFlag: #embedded description: 'run as a packaged application (passed by the PharoApplicationGenerator launcher)';
		yourself

NGPictoCommand >> execute
	self doNotQuitImage.
	NGApplication new launch
```

Two details matter:

- **Declare the `--embedded` flag.** The launcher always runs `picto --embedded`, and Clap rejects a command
  line with an unknown flag. A test checks it:

  ```smalltalk
  NGPictoCommandTest >> testPictoWithEmbeddedFlagIsAValidCommandLine
  	self assert: (ClapContext withPragmaCommands arguments: #( 'picto' '--embedded' ); yourself) match isValid
  ```

- **`doNotQuitImage`.** By default a Clap command quits the image when it is done.
  A game must keep running after `execute` returns.

You can try the entry point without packaging anything:

```
./pharo Picto.image picto
```

### Launching the game

`NGApplication >> launch` does what the entry point is for:

```smalltalk
NGApplication >> launch
	OSWindowDriver current startUp: true.
	AppGeneratorSupport isEmbedded ifTrue: [ self installErrorHandling ].
	OSPlatform current isMacOSX ifTrue: [ self macMenu setAsMainMenu ].
	^ self openMainWindow

NGApplication >> openMainWindow
	| space |
	space := self openPicker.
	space addEventHandlerOn: BlSpaceClosedEvent do: [ :event | self quit ].
	^ space

NGApplication >> quit
	self quitBlock value

NGApplication >> quitBlock
	^ quitBlock ifNil: [ quitBlock := [ Smalltalk snapshot: false andQuit: true ] ]
```

- It starts the SDL window driver, which the headless VM does not start.
- It opens the first window: the puzzle picker (`NGPuzzlePickerElement`). Each puzzle then opens in its own window.
- When the picker window closes, it quits **without saving the image**: the next launch starts fresh.
- Takuzu registers the close handler with `BlSpace>>#when:do:`; current Bloc only has `addEventHandlerOn:do:`.
- The quit action is a block so that a test can open the real window, close it, and check that the application
  would quit, without quitting the test image. Bloc delivers the close event on a later pulse, so the test waits for it.

## 3. A native macOS menu bar

On macOS, an application without a menu bar feels foreign. ObjCBridge gives access to Cocoa,
and its `CocoaMenu` builds a native menu bar from blocks:

```smalltalk
NGApplication >> macMenu
	| menu |
	menu := CocoaMenu new.
	menu title: 'MainMenu'.
	menu addSubmenu: 'Application' with: [ :m |
		m addItemWithTitle: 'Quit' action: [ self quit ] shortcut: 'q' ].
	menu addSubmenu: 'Puzzles' with: [ :m |
		self puzzleMenuItems do: [ :item |
			m addItemWithTitle: item key action: [ NGGameElement openOn: item value ] ] ].
	menu addSubmenu: 'Help' with: [ :m |
		m addItemWithTitle: 'About ' , self appName action: [ self showAbout ] ].
	^ menu
```

- The first submenu becomes the application menu, under the application name: there goes *Quit* (⌘Q).
- The *Puzzles* menu is built from the puzzle library, so a new puzzle appears in the menu without any change here.
- `CocoaMenu` only describes the menu: Cocoa is called by `setAsMainMenu`. So `macMenu` can be built and tested
  on any platform.

**In Pharo 14, ObjCBridge needs one method back.** Its callout builder (`ObjCCalloutMethodBuilder>>#generateFFICallout:spec:`)
sends `methodProperties` to a context, which Pharo 14 removed. Every Cocoa call then fails, starting with
`setAsMainMenu`. Picto restores it:

```smalltalk
Context >> methodProperties
	"*Nonogram-App"
	^ self method properties
```

On Windows and Linux there is no menu bar: the picker window is the whole interface.

## 4. Report errors instead of opening a debugger

In a packaged application, nobody can use a debugger. PharoApplicationGenerator lets you register an error handler:

```smalltalk
AppGeneratorSupport errorHandler: AppGeneratorSDLMessageErrorHandler new
```

`AppGeneratorSDLMessageErrorHandler` shows the error in a native message box and quits;
`AppGeneratorNullErrorHandler` just quits. You can write your own (log to a file, send a report…):
it only has to understand `unhandledError:` and answer whether it handled the error.

**In Pharo 14 this handler is never called.** PharoApplicationGenerator hooks it on `CommandLineUIManager`,
which Pharo 14 removed (loading warns that `CommandLineUIManager>>#unhandledErrorDefaultAction:` cannot be loaded).
Pharo 14 handles unhandled errors with an `ErrorHandler` (`ErrorHandler default`), so Picto plugs the same behavior
there, with a small subclass:

```smalltalk
ErrorHandler << #NGAppErrorHandler
	slots: { #appHandler . #fallbackHandler };
	package: 'Nonogram-App'

NGAppErrorHandler >> handleError: anError log: shouldLog
	(self appHandler value: anError) ifTrue: [ ^ self ].
	self fallbackHandler handleError: anError log: shouldLog

NGAppErrorHandler >> appHandler
	^ appHandler ifNil: [ appHandler := [ :error | AppGeneratorSupport unhandledErrorDefaultAction: error ] ]

NGAppErrorHandler >> fallbackHandler
	^ fallbackHandler ifNil: [ fallbackHandler := ErrorHandler default ]

NGAppErrorHandler class >> install
	| handler |
	handler := self new.
	handler fallbackHandler.
	ErrorHandler default: handler.
	^ handler
```

and installs both when the image runs embedded:

```smalltalk
NGApplication >> installErrorHandling
	AppGeneratorSupport errorHandler: AppGeneratorSDLMessageErrorHandler new.
	NGAppErrorHandler install
```

`AppGeneratorSupport unhandledErrorDefaultAction:` only acts with `--embedded`, so in a development image
errors still open the debugger.

### Saving and quitting in Pharo 14

AppGenerator-Support also overrides `SmalltalkImage>>#snapshot:andQuit:` to refuse saving a read-only image.
The override asks the session `isReadOnlyAccessMode`, a method Pharo 14 removed. Once AppGenerator-Support is loaded,
**every save and every quit fails** with `WorkingSession>>#isReadOnlyAccessMode` not understood:
the `eval --save` of the build script, the *Quit* of the application, and saving your development image.
Picto restores it in `Nonogram-App`:

```smalltalk
WorkingSession >> isReadOnlyAccessMode
	"*Nonogram-App"
	^ false
```

Pharo 14 has no read-only image mode, and the packaged application never saves its image.

### Detecting `--embedded` in Pharo 14

`AppGeneratorSupport isEmbedded` asks `Smalltalk argumentsInclude: '--embedded'`, another method Pharo 14 removed.
The packaged application then fails as soon as `launch` asks it. Picto restores it from `Smalltalk arguments`:

```smalltalk
SmalltalkImage >> argumentsInclude: aString
	"*Nonogram-App"
	^ self arguments includes: aString
```

Unit tests did not reveal this one: it only shows when the image runs from the command line.
Run the entry point of the built image once before packaging:

```
./pharo Picto.image picto --embedded
```

## 5. Describe the application

A generator takes a dictionary of properties. `NGApplication` builds it:

```smalltalk
NGApplication >> commonProperties
	^ Dictionary new
		at: #AppName put: 'Picto';
		at: #DisplayName put: 'Picto';
		at: #InfoString put: 'Picto is a simple nonogram game developed in Pharo';
		at: #BundleIdentifier put: 'org.pharo.picto';
		at: #ShortVersion put: '1.0.0';
		at: #CommandLineHandler put: NGPictoCommand commandName;
		at: #VMZipFile put: 'latest12.zip';
		at: #VMIncludeZipFile put: 'latest12.zip';
		yourself

NGApplication >> osxProperties
	^ self commonProperties
		at: #IconSetFile put: self iconSetFile;
		yourself

NGApplication >> windowsProperties
	^ self commonProperties
		at: #IconFile put: self iconFile;
		at: #CompanyName put: 'Pharo Consortium';
		at: #LegalCopyright put: 'Copyright \251 https://www.pharo.org 2026\0';
		yourself
```

(The real methods use one accessor per value; they are inlined here.)

| Property | Used for | Default |
|---|---|---|
| `AppName` | executable and bundle name (`Picto.app`), DMG name, `CFBundleName` | `MyApp` |
| `DisplayName` | `CFBundleDisplayName`, the name shown by Finder | `My App` |
| `InfoString` | `CFBundleGetInfoString`, the description shown by *Get Info*; Windows file description | `My Test Application` |
| `BundleIdentifier` | `CFBundleIdentifier`, the unique id of the application on macOS | `org.pharo.example` |
| `ShortVersion` | `CFBundleShortVersionString`; Windows file and product version | `0.0.1` |
| `Version` | `CFBundleVersion` | `ShortVersion` |
| `CommandLineHandler` | first argument given to the image: the name of your command | `appGeneratorExample` |
| `IconSetFile` (macOS) | the `.icns` copied into the bundle | a generic icon |
| `IconFile` (Windows) | the `.ico` embedded in the executable | a generic icon |
| `CompanyName`, `LegalCopyright` (Windows) | Windows version resource | `MyCompany`, `My Company Copyright` |
| `VMZipFile`, `VMIncludeZipFile` | the headless VM downloaded from `files.pharo.org/vm/pharo-spur64-headless/` | `latest10.zip` |
| `ImageFile` | the image to embed | the running image |

Three of them deserve a remark:

- **`VMZipFile`**: the default `latest10.zip` is the VM line of Pharo 10. For Pharo 14, use `latest12.zip`:
  it is the same VM as the one `get.pharo.org/64/140+vm` installs.
- **`LegalCopyright`** is written into a C resource file: `\251` is the © sign and `\0` ends the string.
- **`ImageFile`** defaults to the running image, so generate the project from the image you want to ship.

`NGApplication` also generates the projects into `build/`:

```smalltalk
NGApplication >> generateOSXPackage
	AppGeneratorOSXGenerator new
		properties: self osxProperties;
		outputDirectory: FileLocator workingDirectory / 'build';
		generate
```

and the same for Windows with `AppGeneratorWindowsGenerator`. Class-side `NGApplication generateOSXPackage` and
`NGApplication generateWindowsPackage` are what the build scripts call.

Tests pin the metadata, so the Info.plist cannot drift silently:

```smalltalk
NGApplicationTest >> testPropertiesLaunchThePictoCommand
	self assert: (application osxProperties at: #CommandLineHandler) equals: NGPictoCommand commandName
```

## 6. Make an icon

macOS wants an `.icns`, Windows an `.ico`. Picto's icon is its own Heart puzzle, solved, drawn with Bloc
in the colors of the game and saved as a 1024×1024 PNG from the image:

```smalltalk
PNGReadWriter putForm: iconElement asForm onFileNamed: 'resources/Picto-1024.png'
```

Then the system tools do the rest:

```
cd resources
mkdir icon.iconset
for s in 16 32 128 256 512; do
  sips -z $s $s Picto-1024.png --out icon.iconset/icon_${s}x${s}.png
  sips -z $((s*2)) $((s*2)) Picto-1024.png --out icon.iconset/icon_${s}x${s}@2x.png
done
iconutil -c icns icon.iconset -o Picto.icns
convert Picto-1024.png -define icon:auto-resize=256,128,64,48,32,16 Picto.ico   # ImageMagick
```

The files are committed in `resources/`, and `NGApplication` finds them relative to the working directory
(`FileLocator workingDirectory / 'resources'`), so the build scripts run from the repository root.

## 7. Build

`buildOSX.sh`, at the repository root, does the whole macOS build:

```bash
if [ -n "$GITHUB_WORKSPACE" ]
then
	REPOSITORY="gitlocal://$GITHUB_WORKSPACE/src"
else
	REPOSITORY="github://Ducasse/Picto:master/src"
fi

wget -O - get.pharo.org/64/140+vm | bash
./pharo Pharo.image save Picto

./pharo Picto.image eval --save "Metacello new
	baseline: 'Nonogram';
	repository: '$REPOSITORY';
	onUpgradeUseLoaded;
	onConflictUseLoaded;
	load: #( 'App' 'Tests' )"

./pharo Picto.image eval "NGApplication generateOSXPackage"

cd build
chmod +x build.sh
./build.sh
```

1. Download a fresh Pharo 14 and its VM, and save the image as `Picto.image`.
2. Load the `App` and `Tests` groups and save. The shipped image is exactly what the baseline describes:
   nothing from your development image leaks into it.
3. Generate the build project in `build/`.
4. Run the generated `build/build.sh`.

`buildWindows.sh` is the same with `generateWindowsPackage`, then `cmake` and the generated
`buildWindowsPackage.ps1` (run from Cygwin).

The generated macOS project contains:

| File | Content |
|---|---|
| `Picto.app/Contents/Info.plist` | the metadata of section 5 |
| `Picto.app/Contents/Resources/icon.icns` | your icon |
| `CMakeLists.txt` | downloads the headless VM (`latest12.zip`) and compiles the launcher |
| `src/`, `include/` | the C launcher: it starts the VM on the embedded image, with a loading window |
| `build.sh` | builds, assembles the bundle, signs it ad hoc and makes the DMG |
| `installer-background.png`, `installer.icns` | the look of the DMG window |

The resulting `Info.plist` for Picto:

```
CFBundleDisplayName        Picto
CFBundleExecutable         Picto
CFBundleGetInfoString      Picto is a simple nonogram game developed in Pharo
CFBundleIdentifier         org.pharo.picto
CFBundleShortVersionString 1.0.0
PharoImageFile             Picto.image
PharoImageParameters       picto --embedded
```

`build.sh` then:

1. runs CMake, which downloads the VM and compiles the launcher (**CMake 4.0 or newer** is required);
2. copies the image, changes and sources into `Picto.app/Contents/Resources/`, and the VM and its plugins into
   `Picto.app/Contents/MacOS/`;
3. signs the bundle ad hoc (`codesign --force --deep -s -`);
4. builds `Picto-Installer.dmg` with `create-dmg`.

Before packaging, run the entry point of the built image as the launcher will:

```
./pharo Picto.image picto --embedded
```

For Picto, this step found three problems after all the unit tests passed: `argumentsInclude:`,
ObjCBridge's `methodProperties`, and `BlSpace>>#when:do:`. The `isReadOnlyAccessMode` problem showed up one step
earlier, in the `eval --save` of the build script. Without `--embedded`, errors are printed on the terminal instead of
ending in the application error handler, which is the quickest way to read them.

## 8. Build in GitHub Actions

Three workflows live in `.github/workflows/`:

| Workflow | Runs on | When | Produces |
|---|---|---|---|
| `matrix.yml` | ubuntu, macOS | push and pull request to `master` | test results (smalltalkCI, `Pharo64-14`) |
| `packagingOSX.yml` | `macos-latest` | push to `master`, manual run | `Picto-Installer.dmg` |
| `packagingWindows.yml` | `windows-latest` | push to `master`, manual run | an `.msi` installer |

The macOS job installs `create-dmg` and ImageMagick with brew and runs `./buildOSX.sh`.
The Windows job installs Advanced Installer (which builds the MSI) and Cygwin
(CMake, clang, make, wget, unzip), then runs `bash ./buildWindows.sh`.

In GitHub Actions, `$GITHUB_WORKSPACE` is set, so the scripts load the checked-out sources with `gitlocal://`:
the package is built from the commit being tested, not from `master` on GitHub.

Each run keeps its package as a build artifact (*Actions* tab, run page, *Artifacts*).
On a push to `master`, the job also moves a tag (`latest-macos` or `latest-windows`) to the commit
and publishes the package in a prerelease of that tag, with
[`softprops/action-gh-release`](https://github.com/softprops/action-gh-release).
So the release pages always offer the latest build:

- https://github.com/Ducasse/Picto/releases/tag/latest-macos
- https://github.com/Ducasse/Picto/releases/tag/latest-windows

Takuzu uses `marvinpinto/action-automatic-releases` for this; that action is archived.
The workflows need `permissions: contents: write` to push the tag and publish the release.

The smalltalkCI configuration (`.smalltalk.ston`) loads the `default` and `App` groups, so the tests
of the packaging code run too.

## 9. Limitations

- **The macOS application is only signed ad hoc** (`codesign -s -` in `build.sh`). Gatekeeper blocks it the first time:
  right-click *Open*, or `xattr -cr /Applications/Picto.app`.
  Distributing without this warning needs an Apple Developer ID certificate and notarization.
- **The macOS application runs on Apple Silicon only.** The build downloads the VM of the machine it runs on,
  and `macos-latest` is an arm64 machine. An Intel build needs a second job on an Intel runner.
- **Pharo 14 needs six adaptations** of what PharoApplicationGenerator, ObjCBridge and Takuzu do:
  a Clap command instead of a `CommandLineHandler`, an `ErrorHandler` subclass to call the application error handler,
  `WorkingSession>>#isReadOnlyAccessMode` for saving and quitting, `SmalltalkImage>>#argumentsInclude:`
  to detect `--embedded`, `Context>>#methodProperties` for ObjCBridge, and the `latest12.zip` VM.
  The three restored methods are extensions in `Nonogram-App`; they belong upstream.
- **The generated CMake projects require CMake 4.0 or newer.** GitHub runners have it; check your local `cmake --version`.
- **The dependencies follow branches** (`master` of PharoApplicationGenerator and ObjCBridge, `Pharo14` of Toplo):
  a change there can break a build. Pin tags or commits once they exist.

## 10. Next steps

- Sign with a Developer ID and notarize in the macOS workflow (certificate and app password as GitHub secrets).
- Add an Intel macOS build, or a universal one.
- Build real releases from version tags (`v1.0.0`), and take `ShortVersion` from the tag.
- Propose the Pharo 14 adaptations upstream to PharoApplicationGenerator, so applications do not need them.

## Summary

| Step | Picto |
|---|---|
| Separate package and group | `Nonogram-App`, group `App` in `BaselineOfNonogram` |
| Entry point | `NGPictoCommand`, Clap command `picto` with an `--embedded` flag |
| Launch | `NGApplication >> launch`: errors, macOS menu, picker window, quit on close |
| Errors | `AppGeneratorSDLMessageErrorHandler` + `NGAppErrorHandler` |
| Metadata | `NGApplication >> osxProperties` / `windowsProperties` |
| Icon | `resources/Picto.icns`, `resources/Picto.ico` |
| Build | `./buildOSX.sh`, `./buildWindows.sh` |
| Publish | `packagingOSX.yml`, `packagingWindows.yml`, rolling prereleases |
