Class {
	#name : 'NGCursorTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
NGCursorTest >> testMoves [
	| cursor |
	cursor := NGCursor height: 3 width: 4.
	cursor moveRight; moveRight; moveDown.
	self assert: (cursor isAtRow: 2 column: 3).
	cursor moveLeft; moveUp.
	self assert: (cursor isAtRow: 1 column: 2)
]

{ #category : 'tests' }
NGCursorTest >> testStartsAtTopLeft [
	| cursor |
	cursor := NGCursor height: 3 width: 4.
	self assert: (cursor isAtRow: 1 column: 1)
]

{ #category : 'tests' }
NGCursorTest >> testStopsAtEdges [
	| cursor |
	cursor := NGCursor height: 3 width: 4.
	cursor moveUp; moveLeft.
	self assert: (cursor isAtRow: 1 column: 1).
	cursor moveToRow: 9 column: 9.
	self assert: (cursor isAtRow: 3 column: 4).
	cursor moveDown; moveRight.
	self assert: (cursor isAtRow: 3 column: 4)
]
