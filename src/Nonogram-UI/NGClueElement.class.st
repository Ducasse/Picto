"
I display the clue of one row or column.

## Responsibility:

- I show the numbers of a clue: stacked for a column, on one line for a row.
- I show myself satisfied (grey numbers on a pale green background) or not.
- I use the font size of the cells so numbers and cells match.

## Collaborators:

- `NGClue` is what I display.
- `NGGameElement` creates me and tells me when I am satisfied.
- `NGPalette` gives my colors and `NGCellElement` my sizes.

## Public API and Key Messages

- `NGClueElement class >> #forColumn:` and `NGClueElement class >> #forRow:` create instances.
- `#showSatisfied`, `#showUnsatisfied`
- `#clue`

```
NGClueElement forColumn: (NGClue blocks: #(2 1))
```

## Internal Representation

- `clue`: <`NGClue`> the displayed clue.
- `texts`: <Array of Strings> the texts of my labels: one per block for a column, a single one for a row.

### Implementation Points

- An empty column clue shows `0`.
"
Class {
	#name : 'NGClueElement',
	#superclass : 'ToElement',
	#instVars : [
		'clue',
		'texts'
	],
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGClueElement class >> forColumn: aClue [
	^ self new setColumnClue: aClue
]

{ #category : 'instance creation' }
NGClueElement class >> forRow: aClue [
	^ self new setRowClue: aClue
]

{ #category : 'accessing' }
NGClueElement >> clue [
	^ clue
]

{ #category : 'initialization' }
NGClueElement >> setColumnClue: aClue [
	clue := aClue.
	texts := (aClue isEmpty ifTrue: [ #(0) ] ifFalse: [ aClue blocks ]) collect: [ :each | each printString ].
	self
		layout: BlLinearLayout vertical alignBottomCenter;
		padding: (BlInsets bottom: 4);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal exact: NGCellElement cellSize.
			layoutConstraints vertical matchParent ].
	self showUnsatisfied
]

{ #category : 'initialization' }
NGClueElement >> setRowClue: aClue [
	clue := aClue.
	texts := Array with: aClue printString.
	self
		layout: BlLinearLayout horizontal alignCenterRight;
		padding: (BlInsets right: 6);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal matchParent.
			layoutConstraints vertical exact: NGCellElement cellSize ].
	self showUnsatisfied
]

{ #category : 'rendering' }
NGClueElement >> showSatisfied [
	self showTextColor: NGPalette satisfiedClueText background: NGPalette satisfiedClueBackground
]

{ #category : 'rendering' }
NGClueElement >> showTextColor: aTextColor background: aBackgroundColor [
	self removeChildren.
	self background: aBackgroundColor.
	texts do: [ :each |
		self addChild: (ToLabel text: (each asRopedText
			foreground: aTextColor;
			fontSize: NGCellElement fontSize;
			yourself)) ]
]

{ #category : 'rendering' }
NGClueElement >> showUnsatisfied [
	self showTextColor: NGPalette clueText background: Color transparent
]
