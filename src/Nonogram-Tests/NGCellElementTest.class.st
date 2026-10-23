Class {
	#name : 'NGCellElementTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

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
