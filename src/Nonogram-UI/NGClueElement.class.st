"
I display the clue of one row or column. A column clue stacks its numbers vertically, a row clue shows them on one line. When the line matches its clue I am shown satisfied: grey numbers on a pale green background.

	NGClueElement forColumn: (NGClue blocks: #(2 1))
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

{ #category : 'colors' }
NGClueElement class >> satisfiedBackgroundColor [
	^ Color r: 0.85 g: 0.95 b: 0.85
]

{ #category : 'colors' }
NGClueElement class >> satisfiedTextColor [
	^ Color gray
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
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal exact: NGCellElement cellSize.
			layoutConstraints vertical fitContent ].
	self showUnsatisfied
]

{ #category : 'initialization' }
NGClueElement >> setRowClue: aClue [
	clue := aClue.
	texts := Array with: aClue printString.
	self
		layout: BlLinearLayout horizontal alignCenterRight;
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical exact: NGCellElement cellSize ].
	self showUnsatisfied
]

{ #category : 'rendering' }
NGClueElement >> showSatisfied [
	self showTextColor: self class satisfiedTextColor background: self class satisfiedBackgroundColor
]

{ #category : 'rendering' }
NGClueElement >> showTextColor: aTextColor background: aBackgroundColor [
	self removeChildren.
	self background: aBackgroundColor.
	texts do: [ :each | self addChild: (ToLabel text: (each asRopedText foreground: aTextColor)) ]
]

{ #category : 'rendering' }
NGClueElement >> showUnsatisfied [
	self showTextColor: Color black background: Color transparent
]
