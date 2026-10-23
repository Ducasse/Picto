Class {
	#name : 'NGSCellElementTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-UI',
	#package : 'SimpleNonogram-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
NGSCellElementTest >> testRendering [
	| cell |
	cell := NGSCellElement row: 2 column: 3.
	self assert: cell row equals: 2.
	self assert: cell column equals: 3.
	NGSCrossedCell new renderOn: cell.
	self assert: cell childrenCount equals: 1.
	NGSFilledCell new renderOn: cell.
	self assert: cell childrenCount equals: 0.
	self assert: cell background paint color equals: Color black
]
