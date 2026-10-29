"
I display one cell of the board.

## Responsibility:

- I show a cell as unknown, filled, crossed or revealed empty, as asked by its cell state.
- I show or hide the keyboard cursor.
- I know my position on the board.

## Collaborators:

- `NGCellState` subclasses call me through `#renderOn:`.
- `NGGameElement` creates me and refreshes me.
- `NGPalette` gives my colors and `NGIcons` the cross.

## Public API and Key Messages

- `NGCellElement class >> #row:column:` creates an instance; `#cellSize` and `#fontSize` give the sizes.
- `#showUnknown`, `#showFilled`, `#showCrossed`, `#showRevealedEmpty`
- `#showCursor`, `#hideCursor`
- `#row`, `#column`

```
NGFilledCell new renderOn: (NGCellElement row: 1 column: 1)
```

## Internal Representation

- `row`: <Integer> my row on the board.
- `column`: <Integer> my column on the board.
"
Class {
	#name : 'NGCellElement',
	#superclass : 'ToElement',
	#instVars : [
		'row',
		'column'
	],
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'accessing' }
NGCellElement class >> cellSize [

	^ 40
]

{ #category : 'accessing' }
NGCellElement class >> fontSize [
	^ 20
]

{ #category : 'instance creation' }
NGCellElement class >> row: aRow column: aColumn [
	^ self new setRow: aRow column: aColumn
]

{ #category : 'accessing' }
NGCellElement >> column [
	^ column
]

{ #category : 'rendering' }
NGCellElement >> hideCursor [
	self border: BlBorder empty
]

{ #category : 'accessing' }
NGCellElement >> row [
	^ row
]

{ #category : 'initialization' }
NGCellElement >> setRow: aRow column: aColumn [
	row := aRow.
	column := aColumn.
	self
		layout: BlFrameLayout new;
		extent: self class cellSize asPoint.
	self showUnknown
]

{ #category : 'rendering' }
NGCellElement >> showCrossed [
	| mark |
	self removeChildren.
	self background: NGPalette emptyCell.
	mark := NGIcons cross.
	mark constraintsDo: [ :layoutConstraints |
		layoutConstraints frame horizontal alignCenter.
		layoutConstraints frame vertical alignCenter ].
	self addChild: mark
]

{ #category : 'rendering' }
NGCellElement >> showCursor [
	self border: (BlBorder paint: NGPalette cursor width: 2)
]

{ #category : 'rendering' }
NGCellElement >> showFilled [
	self removeChildren.
	self background: NGPalette filledCell
]

{ #category : 'rendering' }
NGCellElement >> showRevealedEmpty [
	self removeChildren.
	self background: NGPalette errorCell
]

{ #category : 'rendering' }
NGCellElement >> showUnknown [
	self removeChildren.
	self background: NGPalette emptyCell
]
