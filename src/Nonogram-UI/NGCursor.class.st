"
I am the keyboard cursor on a grid: I know which cell the keyboard acts on.

## Responsibility:

- I hold the current cell, starting at row 1, column 1.
- I move up, down, left and right, or jump to a given cell.
- I stop at the edges of the grid rather than wrapping around.

## Collaborators:

- `NGGameElement` owns me, moves me on arrow keys and clicks, and draws me on the cell I point to.

## Public API and Key Messages

- `NGCursor class >> #height:width:` creates an instance on a grid of that size.
- `#moveUp`, `#moveDown`, `#moveLeft`, `#moveRight`, `#moveToRow:column:`
- `#row`, `#column`, `#isAtRow:column:`

```
(NGCursor height: 5 width: 5) moveRight; column
```

## Internal Representation

- `row`: <Integer> the current row.
- `column`: <Integer> the current column.
- `height`: <Integer> the number of rows of the grid.
- `width`: <Integer> the number of columns of the grid.
"
Class {
	#name : 'NGCursor',
	#superclass : 'Object',
	#instVars : [
		'row',
		'column',
		'height',
		'width'
	],
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGCursor class >> height: aHeight width: aWidth [
	^ self new setHeight: aHeight width: aWidth
]

{ #category : 'accessing' }
NGCursor >> column [
	^ column
]

{ #category : 'testing' }
NGCursor >> isAtRow: aRow column: aColumn [
	^ row = aRow and: [ column = aColumn ]
]

{ #category : 'moving' }
NGCursor >> moveDown [
	self moveToRow: row + 1 column: column
]

{ #category : 'moving' }
NGCursor >> moveLeft [
	self moveToRow: row column: column - 1
]

{ #category : 'moving' }
NGCursor >> moveRight [
	self moveToRow: row column: column + 1
]

{ #category : 'moving' }
NGCursor >> moveToRow: aRow column: aColumn [
	row := aRow clampBetween: 1 and: height.
	column := aColumn clampBetween: 1 and: width
]

{ #category : 'moving' }
NGCursor >> moveUp [
	self moveToRow: row - 1 column: column
]

{ #category : 'accessing' }
NGCursor >> row [
	^ row
]

{ #category : 'initialization' }
NGCursor >> setHeight: aHeight width: aWidth [
	height := aHeight.
	width := aWidth.
	row := 1.
	column := 1
]
