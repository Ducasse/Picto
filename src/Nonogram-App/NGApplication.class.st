"
I describe Picto, the Nonogram game packaged as a desktop application, and I know how to launch it and how to package it.

## Responsibility:

- I know the application metadata (name, info string, bundle identifier, version, icons) given to PharoApplicationGenerator.
- I generate the macOS and Windows build projects with `AppGeneratorOSXGenerator` and `AppGeneratorWindowsGenerator`.
- I launch the game: error handling, native macOS menu, puzzle picker, and quitting when the picker window closes.

## Collaborators: 

- `NGPictoCommand` is the `picto` command line entry point; it asks me to `#launch`.
- `NGPuzzlePickerElement` and `NGGameElement` are the windows I open.
- `NGPuzzleLibrary` gives the puzzles listed in the macOS Puzzles menu.
- `AppGeneratorSupport` and `NGAppErrorHandler` show unhandled errors in a message box when the application is embedded.
- `CocoaMenu` (ObjCBridge) builds the native macOS menu bar.

## Public API and Key Messages

- `NGApplication class >> #generateOSXPackage` and `#generateWindowsPackage` are called by `buildOSX.sh` and `buildWindows.sh`.
- `#osxProperties` and `#windowsProperties` answer the dictionaries given to the generators.
- `#launch` starts the application; `#openMainWindow` opens the puzzle picker, whose closing quits.

```
NGApplication new osxProperties.
NGApplication new launch.
```

See `NGApplication class >> #exampleDefault`.

## Internal Representation

- `quitBlock`: <BlockClosure> run when the main window closes; by default it quits the image without saving. Tests replace it.

My metadata are constants.

### Implementation Points

- Icons are read from `resources/` in the working directory, so the build scripts must run from the repository root.
- Generated build projects go to `build/` in the working directory.
"
Class {
	#name : 'NGApplication',
	#superclass : 'Object',
	#instVars : [
		'quitBlock'
	],
	#category : 'Nonogram-App',
	#package : 'Nonogram-App'
}

{ #category : 'examples' }
NGApplication class >> exampleDefault [

	<sampleInstance>
	^ self new
]

{ #category : 'packaging' }
NGApplication class >> generateOSXPackage [
	"Called by buildOSX.sh"

	self new generateOSXPackage
]

{ #category : 'packaging' }
NGApplication class >> generateWindowsPackage [
	"Called by buildWindows.sh"

	self new generateWindowsPackage
]

{ #category : 'script' }
NGApplication class >> scriptOpenPicker [
	"Open the window the application starts with, without quitting the image when it closes (use #launch for that)."

	<script>
	self new openPicker
]

{ #category : 'metadata' }
NGApplication >> aboutText [

	^ self appName , ' ' , self shortVersion , String cr , self infoString
]

{ #category : 'metadata' }
NGApplication >> appName [

	^ 'Picto'
]

{ #category : 'metadata' }
NGApplication >> bundleIdentifier [

	^ 'org.pharo.picto'
]

{ #category : 'packaging' }
NGApplication >> commonProperties [
	"Properties shared by the macOS and Windows generators"

	^ Dictionary new
		  at: #AppName put: self appName;
		  at: #DisplayName put: self appName;
		  at: #InfoString put: self infoString;
		  at: #BundleIdentifier put: self bundleIdentifier;
		  at: #ShortVersion put: self shortVersion;
		  at: #CommandLineHandler put: NGPictoCommand commandName;
		  yourself
]

{ #category : 'metadata' }
NGApplication >> companyName [

	^ 'Pharo Consortium'
]

{ #category : 'packaging' }
NGApplication >> generateOSXPackage [
	"Generate the macOS build project (CMake, Info.plist, build.sh) in build/"

	AppGeneratorOSXGenerator new
		properties: self osxProperties;
		outputDirectory: self outputDirectory;
		generate
]

{ #category : 'packaging' }
NGApplication >> generateWindowsPackage [
	"Generate the Windows build project (CMake, resources, installer scripts) in build/"

	AppGeneratorWindowsGenerator new
		properties: self windowsProperties;
		outputDirectory: self outputDirectory;
		generate
]

{ #category : 'files' }
NGApplication >> iconFile [

	^ self resourcesDirectory / 'Picto.ico'
]

{ #category : 'files' }
NGApplication >> iconSetFile [

	^ self resourcesDirectory / 'Picto.icns'
]

{ #category : 'metadata' }
NGApplication >> infoString [

	^ 'Picto is a simple nonogram game developed in Pharo'
]

{ #category : 'launching' }
NGApplication >> installErrorHandling [
	"Show unhandled errors in a message box and quit, as PharoApplicationGenerator does"

	AppGeneratorSupport errorHandler: AppGeneratorSDLMessageErrorHandler new.
	NGAppErrorHandler install
]

{ #category : 'launching' }
NGApplication >> launch [
	"Start the packaged application: error handling, native macOS menu, then the main window. Closing it quits."

	OSWindowDriver current startUp: true.
	AppGeneratorSupport isEmbedded ifTrue: [ self installErrorHandling ].
	OSPlatform current isMacOSX ifTrue: [ self macMenu beMainMenu ].
	^ self openMainWindow
]

{ #category : 'metadata' }
NGApplication >> legalCopyright [
	"Written into a Windows resource file: \251 is the copyright sign, \0 ends the C string"

	^ 'Copyright \251 https://www.pharo.org 2026\0'
]

{ #category : 'menu' }
NGApplication >> macMenu [
	"Answer the native macOS menu bar. It is only described here: Cocoa is touched when it is set as main menu."

	| menu |
	menu := CocoaMenu new.
	menu title: 'MainMenu'.
	menu addSubmenu: 'Application' with: [ :m | m addItemWithTitle: 'Quit' action: [ self quit ] shortcut: 'q' ].
	menu
		addSubmenu: 'Puzzles'
		with: [ :m | self puzzleMenuItems do: [ :item | m addItemWithTitle: item key action: [ NGGameElement openOn: item value ] ] ].
	menu addSubmenu: 'Help' with: [ :m | m addItemWithTitle: 'About ' , self appName action: [ self showAbout ] ].
	^ menu
]

{ #category : 'launching' }
NGApplication >> openMainWindow [
	"Open the puzzle picker; closing it quits the application"

	| space |
	space := self openPicker.
	space addEventHandlerOn: BlSpaceClosedEvent do: [ :event | self quit ].
	^ space
]

{ #category : 'launching' }
NGApplication >> openPicker [

	^ NGPuzzlePickerElement open
]

{ #category : 'packaging' }
NGApplication >> osxProperties [

	^ self commonProperties
		  at: #IconSetFile put: self iconSetFile;
		  yourself
]

{ #category : 'files' }
NGApplication >> outputDirectory [

	^ FileLocator workingDirectory / 'build'
]

{ #category : 'menu' }
NGApplication >> puzzleMenuItems [
	"Answer an association menu title -> puzzle for each puzzle of the default library"

	^ NGPuzzleLibrary default puzzles collect: [ :puzzle | puzzle name -> puzzle ]
]

{ #category : 'launching' }
NGApplication >> quit [

	self quitBlock value
]

{ #category : 'launching' }
NGApplication >> quitBlock [

	^ quitBlock ifNil: [ quitBlock := [ Smalltalk snapshot: false andQuit: true ] ]
]

{ #category : 'launching' }
NGApplication >> quitBlock: aBlock [

	quitBlock := aBlock
]

{ #category : 'files' }
NGApplication >> resourcesDirectory [
	"The build scripts run from the repository root, where resources/ holds the icons"

	^ (IceRepository repositoryNamed: 'Picto') 
		ifNotNil: [ :repo | repo location / 'resources' ]
		ifNil: [ FileLocator workingDirectory / 'resources' ]
]

{ #category : 'metadata' }
NGApplication >> shortVersion [

	^ '1.0.0'
]

{ #category : 'launching' }
NGApplication >> showAbout [

	SDL2
		showSimpleMessageBox: self aboutText
		title: 'About ' , self appName
		flags: 16r00000040
		window: ExternalAddress null
]

{ #category : 'packaging' }
NGApplication >> windowsProperties [

	^ self commonProperties
		  at: #IconFile put: self iconFile;
		  at: #CompanyName put: self companyName;
		  at: #LegalCopyright put: self legalCopyright;
		  yourself
]
