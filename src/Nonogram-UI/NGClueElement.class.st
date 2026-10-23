"
I display the clue of one row or column.

Responsibility:
- show the numbers of a clue: stacked for a column, on one line for a row
- show myself satisfied (grey numbers on a pale green background) or not

Collaborators: NGClue; NGGameElement creates and updates me.

Public API and Key Messages:
- NGClueElement class >> #forColumn: and #forRow: create me
- #showSatisfied, #showUnsatisfied

	NGClueElement forColumn: (NGClue blocks: #(2 1))

Internal Representation and Key Implementation Points.

Instance Variables
	clue:	<NGClue> the displayed clue
	texts:	<Array of Strings> the texts of my labels
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
