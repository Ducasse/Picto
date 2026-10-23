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
	self showMark: Color black
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
NGCellElement >> showMark: aColor [
	| mark |
	self removeChildren.
	self background: Color veryVeryLightGray.
	mark := ToLabel text: ('x' asRopedText
		foreground: aColor;
		fontSize: self class fontSize;
		yourself).
	mark constraintsDo: [ :layoutConstraints |
		layoutConstraints frame horizontal alignCenter.
		layoutConstraints frame vertical alignCenter ].
	self addChild: mark
]

{ #category : 'rendering' }
NGCellElement >> showRevealedEmpty [
	self showMark: Color red
]

{ #category : 'rendering' }
NGCellElement >> showUnknown [
	self removeChildren.
	self background: Color white
]
