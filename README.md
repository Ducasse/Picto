# Picto

Picto is a simple nonogram game developed in Pharo.

[![License](https://img.shields.io/badge/license-MIT-blue.svg)](https://img.shields.io/badge/license-MIT-blue.svg)
[![matrix](https://github.com/Ducasse/Picto/actions/workflows/matrix.yml/badge.svg)](https://github.com/Ducasse/Picto/actions/workflows/matrix.yml)
[![Packaging for macOS](https://github.com/Ducasse/Picto/actions/workflows/packagingOSX.yml/badge.svg)](https://github.com/Ducasse/Picto/actions/workflows/packagingOSX.yml)
[![Packaging for Windows](https://github.com/Ducasse/Picto/actions/workflows/packagingWindows.yml/badge.svg)](https://github.com/Ducasse/Picto/actions/workflows/packagingWindows.yml)

<img width="731" height="636" alt="Capture 2026-10-23 at 15 27 39" src="https://github.com/user-attachments/assets/75bca3a4-f73e-4bc8-9d4e-5dbeb0f0c62d" />

## Download

Development builds are published at each change of `master`:

- macOS (Apple Silicon): [Picto-Installer.dmg](https://github.com/Ducasse/Picto/releases/tag/latest-macos)
- Windows: [Picto installer (.msi)](https://github.com/Ducasse/Picto/releases/tag/latest-windows)

The macOS application is not signed with an Apple Developer ID, so Gatekeeper blocks it the first time.
Right-click `Picto.app` and choose *Open*, or run:

```
xattr -cr /Applications/Picto.app
```

## Load it in Pharo 14

```smalltalk
Metacello new
	baseline: 'Nonogram';
	repository: 'github://Ducasse/Picto:master/src';
	load
```

Then run `NGPuzzlePickerElement open`.

The `App` group adds what the packaged application needs (the `picto` command line, the native macOS menu,
the packaging metadata): `load: #( 'App' )`.

## How to play

Choose a puzzle, then fill the cells of the grid so that each row and column matches its clues:
a clue `3 1` means a run of three filled cells, then at least one empty cell, then one filled cell.

- Click fills a cell, right-click crosses it.
- With the keyboard: arrows move the cursor, Space or F fills, X crosses, Backspace or Delete clears.
- Filling a cell that should stay empty costs one of your three lives.

On macOS, the *Puzzles* menu opens any puzzle directly.

## Packaging

Picto is packaged with [PharoApplicationGenerator](https://github.com/tesonep/PharoApplicationGenerator).
[doc/PackagingAPharoApp.md](doc/PackagingAPharoApp.md) explains every step, using Picto as the example.
