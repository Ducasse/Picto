"
I display one cell of the board. My cell state tells me how to look through #renderOn:.
"
Class {
	#name : 'NGSCellElement',
	#superclass : 'ToElement',
	#instVars : [
		'row',
		'column'
	],
	#category : 'SimpleNonogram-UI-Core',
	#package : 'SimpleNonogram-UI',
	#tag : 'Core'
}

{ #category : 'accessing' }
NGSCellElement class >> cellSize [
	^ 28
]

{ #category : 'instance creation' }
NGSCellElement class >> row: aRow column: aColumn [
	^ self new setRow: aRow column: aColumn
]

{ #category : 'accessing' }
NGSCellElement >> column [
	^ column
]

{ #category : 'accessing' }
NGSCellElement >> row [
	^ row
]

{ #category : 'initialization' }
NGSCellElement >> setRow: aRow column: aColumn [
	row := aRow.
	column := aColumn.
	self
		layout: BlFrameLayout new;
		extent: self class cellSize asPoint;
		border: (BlBorder paint: Color gray width: 1).
	self showUnknown
]

{ #category : 'rendering' }
NGSCellElement >> showCrossed [
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
NGSCellElement >> showFilled [
	self removeChildren.
	self background: Color black
]

{ #category : 'rendering' }
NGSCellElement >> showUnknown [
	self removeChildren.
	self background: Color white
]
