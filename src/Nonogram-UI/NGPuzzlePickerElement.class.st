"
I display the puzzles of an `NGPuzzleLibrary` so the player can choose one.

## Responsibility:

- I list each puzzle as a button showing its name and size.
- I open a new fitted game window on the chosen puzzle.
- I size my buttons so the longest allowed name fits.

## Collaborators:

- `NGPuzzleLibrary` gives the puzzles offered.
- `NGGameElement` is opened on the chosen puzzle.
- `NGWindow` opens me; `NGPalette` gives my colors.

## Public API and Key Messages

- `NGPuzzlePickerElement class >> #on:` creates an instance on a library; `NGPuzzlePickerElement class >> #open` opens a picker on the default library.
- `#play:` opens a game on a puzzle.
- `#open` opens me in a fitted window.

```
NGPuzzlePickerElement open
```

## Internal Representation

- `library`: <`NGPuzzleLibrary`> the puzzles offered.

### Implementation Points

- Each game opens in its own window, so several puzzles can be played at once.
- `NGPuzzlePickerElement class >> #buttonWidth` fits a name of `NGPuzzle class >> #maxNameSize` characters followed by the largest size.
"
Class {
	#name : 'NGPuzzlePickerElement',
	#superclass : 'ToElement',
	#instVars : [
		'library'
	],
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'constants' }
NGPuzzlePickerElement class >> buttonWidth [
	"Answer the width of a puzzle button: enough for a name of NGPuzzle maxNameSize characters followed by the largest size"
	^ 260
]

{ #category : 'examples' }
NGPuzzlePickerElement class >> example [
	<script>
	self open
]

{ #category : 'instance creation' }
NGPuzzlePickerElement class >> on: aPuzzleLibrary [
	^ self new setLibrary: aPuzzleLibrary
]

{ #category : 'opening' }
NGPuzzlePickerElement class >> open [
	"Open a picker on the default library"
	^ (self on: NGPuzzleLibrary default) open
]

{ #category : 'accessing' }
NGPuzzlePickerElement >> buttons [
	^ self children asArray allButFirst
]

{ #category : 'building' }
NGPuzzlePickerElement >> labelFor: aPuzzle [
	^ aPuzzle name , '  (' , aPuzzle width printString , ' x ' , aPuzzle height printString , ')'
]

{ #category : 'accessing' }
NGPuzzlePickerElement >> library [
	^ library
]

{ #category : 'building' }
NGPuzzlePickerElement >> newButtonFor: aPuzzle [
	^ (ToButton labelText: (self labelFor: aPuzzle))
		clickAction: [ self play: aPuzzle ];
		constraintsDo: [ :layoutConstraints | layoutConstraints horizontal exact: self class buttonWidth ];
		yourself
]

{ #category : 'opening' }
NGPuzzlePickerElement >> open [
	^ NGWindow open: self titled: 'Nonograms'
]

{ #category : 'actions' }
NGPuzzlePickerElement >> play: aPuzzle [
	"Open a new game window on aPuzzle"
	^ NGGameElement openOn: aPuzzle
]

{ #category : 'initialization' }
NGPuzzlePickerElement >> setLibrary: aPuzzleLibrary [
	library := aPuzzleLibrary.
	self
		layout: (BlLinearLayout vertical cellSpacing: 8);
		padding: (BlInsets all: 16);
		background: NGPalette background;
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ].
	self addChild: (ToLabel text: ('Choose a puzzle' asRopedText
		foreground: NGPalette clueText;
		fontSize: NGCellElement fontSize;
		yourself)).
	library puzzles do: [ :puzzle | self addChild: (self newButtonFor: puzzle) ]
]
