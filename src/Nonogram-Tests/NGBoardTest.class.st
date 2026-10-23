"
I test NGBoard.
"
Class {
	#name : 'NGBoardTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGBoardTest >> testInitiallyUnknown [
	| board |
	board := NGBoard height: 2 width: 3.
	self assert: board height equals: 2.
	self assert: board width equals: 3.
	self assert: ((board rowAt: 1) allSatisfy: [ :c | c = NGUnknownCell new ])
]

{ #category : 'tests' }
NGBoardTest >> testPutAndLines [
	| board |
	board := NGBoard height: 2 width: 2.
	board atRow: 1 column: 2 put: NGFilledCell new.
	board atRow: 2 column: 2 put: NGCrossedCell new.
	self assert: (board filledRowAt: 1) equals: #(false true).
	self assert: (board filledColumnAt: 2) equals: #(true false).
	self assert: board printString equals: '.#', String cr, '.x'.
	board reset.
	self assert: (board atRow: 1 column: 2) equals: NGUnknownCell new
]

{ #category : 'tests' }
NGBoardTest >> testShowSolvedClearsCrosses [
	| board |
	board := NGBoard height: 1 width: 4.
	board atRow: 1 column: 1 put: NGFilledCell new.
	board atRow: 1 column: 2 put: NGCrossedCell new.
	board atRow: 1 column: 3 put: NGRevealedEmptyCell new.
	board showSolved.
	self assert: board printString equals: '#...'
]
