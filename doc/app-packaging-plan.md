# Plan: package Picto (Nonogram) as a desktop application

Agreed on 2026-11-02. Reference projects:
- https://github.com/tesonep/PharoApplicationGenerator (the generator)
- https://github.com/tesonep/Takuzu (an application packaged with it)

## Decisions

1. **Pharo version**: Pharo 14 (`get.pharo.org/64/140+vm`) for both macOS and Windows.
2. **Code location**: new package `Nonogram-App` in this repository, holding
   - `NGCommandLineHandler` (subclass of `CommandLineHandler`)
   - `NGApplication` (class side: `generateOSXPackage`, `generateWindowsPackage`, `iconFile`, `iconSetFile`).
   `Nonogram`, `Nonogram-UI`, `Nonogram-Tests` stay untouched.
3. **Metadata** (AppGenerator properties):
   - `AppName` / `DisplayName`: `Picto`
   - `CommandLineHandler`: `picto`
   - `BundleIdentifier`: `org.pharo.picto`
   - `InfoString`: `Picto is a simple nonogram game developed in Pharo`
   - `ShortVersion`: `1.0.0`
   - Windows `CompanyName`: `Pharo Consortium`; `LegalCopyright`: `Copyright © https://www.pharo.org 2026`
4. **Command line handler `activate`**:
   - start the OSWindow driver, install `AppGeneratorSDLMessageErrorHandler`;
   - open `NGPuzzlePickerElement`; quit (`Smalltalk snapshot: false andQuit: true`) when its space closes;
   - on macOS, also a native `CocoaMenu`: Application › Quit (⌘Q); Puzzles › one item per puzzle of `NGPuzzleLibrary default` (opens `NGGameElement openOn:`); Help › About Picto.
   - Fallback: if ObjCBridge does not work on Pharo 14, drop the native menu.
5. **Icon**: render the solved `NGPuzzles heart` at 1024 px, convert to `resources/Picto.icns` (iconutil) and `resources/Picto.ico` (ImageMagick); resolve via `FileLocator workingDirectory / 'resources'`.
6. **Baseline** (`BaselineOfNonogram`):
   - dependencies `ApplicationGenerator` (`github://tesonep/PharoApplicationGenerator:master/src`) and `ObjCBridge` (`github://tesonep/objcbridge:master/src`);
   - package `Nonogram-App` requires `Nonogram-UI`, `ApplicationGenerator`, `ObjCBridge`;
   - new group `App`; `default` stays `Core UI Tests`;
   - the build scripts load `App` and `Tests` (tests are shipped);
   - `SimpleNonogram*` packages stay out of the baseline;
   - update the class comment.
7. **CI / workflows**:
   - fix `matrix.yml` (Pharo64-14, ubuntu + macOS) and `.smalltalk.ston` (baseline `Nonogram`, tests `Nonogram-Tests`);
   - `packagingOSX.yml` (DMG) and `packagingWindows.yml` (MSI via Advanced Installer + Cygwin), triggered on push to `master` and `workflow_dispatch`;
   - rolling prereleases `latest-macos` / `latest-windows` via `softprops/action-gh-release`; `actions/checkout@v4`;
   - `buildOSX.sh` / `buildWindows.sh` at the repository root: `gitlocal://` in CI, `github://Ducasse/Picto:master/src` locally.
8. **macOS distribution**: ad-hoc signing only (Gatekeeper workaround documented), arm64 only. Follow-ups: Developer ID signing, notarization, Intel build.
9. **Git**: branch `app-packaging`, a few logical commits; verify locally (tests green, `generateOSXPackage` runs, `./buildOSX.sh` produces a DMG that launches), then push and open a PR to `master`. Windows is only verifiable via `workflow_dispatch` on the branch.
10. **Documentation**:
    - `doc/PackagingAPharoApp.md`: a general PharoApplicationGenerator guide with Picto as the worked example; technical, no prerequisites section; usable as the README of tesonep/PharoApplicationGenerator and as a blog post.
    - Picto `README.md`: small update (info string, download links, Gatekeeper note, fixed badge, link to the guide).
    - No contact with the tesonep repository; the user proposes the guide there.
