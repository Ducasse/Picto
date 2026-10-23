"
I display one cell of the board. My cell state tells me how to look through #renderOn:.
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
	^ 28
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
	self background: Color veryVeryLightGray.
	mark := ToLabel text: 'x'.
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
NGCellElement >> showUnknown [
	self removeChildren.
	self background: Color white
]
