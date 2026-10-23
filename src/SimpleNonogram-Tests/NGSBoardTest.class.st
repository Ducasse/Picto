Class {
	#name : 'NGSBoardTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-Core',
	#package : 'SimpleNonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGSBoardTest >> testInitiallyUnknown [
	| board |
	board := NGSBoard height: 2 width: 3.
	self assert: board height equals: 2.
	self assert: board width equals: 3.
	self assert: ((board rowAt: 1) allSatisfy: [ :c | c = NGSUnknownCell new ])
]

{ #category : 'tests' }
NGSBoardTest >> testPutAndLines [
	| board |
	board := NGSBoard height: 2 width: 2.
	board atRow: 1 column: 2 put: NGSFilledCell new.
	board atRow: 2 column: 2 put: NGSCrossedCell new.
	self assert: (board filledRowAt: 1) equals: #(false true).
	self assert: (board filledColumnAt: 2) equals: #(true false).
	self assert: board printString equals: '.#', String cr, '.x'.
	board reset.
	self assert: (board atRow: 1 column: 2) equals: NGSUnknownCell new
]
