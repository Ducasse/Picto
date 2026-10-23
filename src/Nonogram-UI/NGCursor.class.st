"
I am the keyboard cursor on a grid.

Responsibility: hold the current cell and move it, stopping at the edges rather than wrapping around.

Collaborators: NGGameElement owns and draws me.

Public API and Key Messages:
- NGCursor class >> #height:width: creates me at row 1, column 1
- #moveUp, #moveDown, #moveLeft, #moveRight, #moveToRow:column:, #row, #column, #isAtRow:column:

	(NGCursor height: 5 width: 5) moveRight; column

Internal Representation and Key Implementation Points.

Instance Variables
	row:		<Integer> the current row
	column:	<Integer> the current column
	height:	<Integer> the number of rows of the grid
	width:	<Integer> the number of columns of the grid
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
