"
I display one cell of the board.

Responsibility:
- show a cell as unknown, filled, crossed or revealed empty, as asked by its cell state
- show or hide the keyboard cursor

Collaborators: NGCellState subclasses call me through #renderOn:; NGGameElement creates me.

Public API and Key Messages:
- NGCellElement class >> #row:column: creates me; #cellSize and #fontSize give the sizes
- #showUnknown, #showFilled, #showCrossed, #showRevealedEmpty, #showCursor, #hideCursor

	NGFilledCell new renderOn: (NGCellElement row: 1 column: 1)

Internal Representation and Key Implementation Points.

Instance Variables
	row:		<Integer> my row on the board
	column:	<Integer> my column on the board
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

{ #category : 'colors' }
NGCellElement class >> errorColor [
	^ Color r: 0.95 g: 0.6 b: 0.6
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
	self border: (BlBorder paint: Color gray width: 1)
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
		extent: self class cellSize asPoint;
		border: (BlBorder paint: Color gray width: 1).
	self showUnknown
]

{ #category : 'rendering' }
NGCellElement >> showCrossed [

	| mark |
	self removeChildren.
	self background: Color white.
	mark := ToLabel text: ('x' asRopedText fontSize: self class fontSize).
	mark constraintsDo: [ :layoutConstraints |
			layoutConstraints frame horizontal alignCenter.
			layoutConstraints frame vertical alignCenter ].
	self addChild: mark
]

{ #category : 'rendering' }
NGCellElement >> showCursor [
	self border: (BlBorder paint: Color blue width: 3)
]

{ #category : 'rendering' }
NGCellElement >> showFilled [
	self removeChildren.
	self background: Color black
]

{ #category : 'rendering' }
NGCellElement >> showRevealedEmpty [
	self removeChildren.
	self background: self class errorColor
]

{ #category : 'rendering' }
NGCellElement >> showUnknown [
	self removeChildren.
	self background: Color white
]
