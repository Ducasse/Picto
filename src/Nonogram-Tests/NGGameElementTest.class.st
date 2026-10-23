Class {
	#name : 'NGGameElementTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'fixtures' }
NGGameElementTest >> element [
	^ NGGameElement on: (NGGame on: (NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')))
]

{ #category : 'tests' }
NGGameElementTest >> testCellsAreBuilt [
	| element |
	element := self element.
	self assert: (element cellAtRow: 3 column: 3) row equals: 3.
	self assert: (element cellAtRow: 1 column: 1) background paint color equals: Color white.
	self assert: element statusText equals: ''
]

{ #category : 'tests' }
NGGameElementTest >> testPrimaryClickFills [
	| element cell |
	element := self element.
	cell := element cellAtRow: 2 column: 2.
	cell dispatchEvent: (BlPrimaryClickEvent new button: BlMouseButton primary; yourself).
	self assert: (element game board atRow: 2 column: 2) equals: NGFilledCell new.
	self assert: cell background paint color equals: Color black
]

{ #category : 'tests' }
NGGameElementTest >> testSecondaryClickCrosses [
	| element cell |
	element := self element.
	cell := element cellAtRow: 1 column: 1.
	cell dispatchEvent: (BlSecondaryClickEvent new button: BlMouseButton secondary; yourself).
	self assert: (element game board atRow: 1 column: 1) equals: NGCrossedCell new.
	self assert: cell childrenCount equals: 1
]

{ #category : 'tests' }
NGGameElementTest >> testSolvingAndUndo [
	| element |
	element := self element.
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p | element fillAtRow: p first column: p second ].
	self assert: element statusText equals: 'Solved!'.
	element undo.
	self assert: element statusText equals: ''.
	element restart.
	self deny: element game canUndo
]
