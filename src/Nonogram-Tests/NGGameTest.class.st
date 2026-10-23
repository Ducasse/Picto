Class {
	#name : 'NGGameTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'fixtures' }
NGGameTest >> game [
	^ NGGame on: (NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.'))
]

{ #category : 'tests' }
NGGameTest >> testNoOpMovesAreNotRecorded [
	| game |
	game := self game.
	game clearAtRow: 1 column: 1.
	self assert: game moveCount equals: 0
]

{ #category : 'tests' }
NGGameTest >> testRestart [
	| game |
	game := self game.
	game toggleFillAtRow: 2 column: 2.
	game restart.
	self assert: (game board atRow: 2 column: 2) equals: NGUnknownCell new.
	self deny: game canUndo
]

{ #category : 'tests' }
NGGameTest >> testSolving [
	| game |
	game := self game.
	self deny: game isSolved.
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p | game toggleFillAtRow: p first column: p second ].
	game toggleCrossAtRow: 1 column: 1.
	self assert: game isSolved
]

{ #category : 'tests' }
NGGameTest >> testUndo [
	| game |
	game := self game.
	self deny: game canUndo.
	game toggleFillAtRow: 1 column: 1.
	game toggleCrossAtRow: 1 column: 1.
	self assert: game moveCount equals: 2.
	game undo.
	self assert: (game board atRow: 1 column: 1) equals: NGFilledCell new.
	game undo.
	self assert: (game board atRow: 1 column: 1) equals: NGUnknownCell new.
	game undo.
	self deny: game canUndo
]
