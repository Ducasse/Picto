Class {
	#name : 'NGCellElementTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
NGCellElementTest >> testCursorRendering [
	| cell |
	cell := NGCellElement row: 1 column: 1.
	cell showCursor.
	self assert: cell border width equals: 3.
	cell hideCursor.
	self assert: cell border width equals: 1
]

{ #category : 'tests' }
NGCellElementTest >> testRendering [
	| cell |
	cell := NGCellElement row: 2 column: 3.
	self assert: cell row equals: 2.
	self assert: cell column equals: 3.
	NGCrossedCell new renderOn: cell.
	self assert: cell childrenCount equals: 1.
	NGFilledCell new renderOn: cell.
	self assert: cell childrenCount equals: 0.
	self assert: cell background paint color equals: Color black
]

{ #category : 'tests' }
NGCellElementTest >> testRevealedEmptyRendering [
	| cell |
	cell := NGCellElement row: 1 column: 1.
	NGRevealedEmptyCell new renderOn: cell.
	self assert: cell childrenCount equals: 1.
	self assert: ((cell children first text attributesAt: 1) anySatisfy: [ :each | each = (BlTextForegroundAttribute paint: Color red) ])
]
