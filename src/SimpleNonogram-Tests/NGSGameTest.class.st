Class {
	#name : 'NGSGameTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-Core',
	#package : 'SimpleNonogram-Tests',
	#tag : 'Core'
}

{ #category : 'fixtures' }
NGSGameTest >> game [
	^ NGSGame on: (NGSPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.'))
]

{ #category : 'tests' }
NGSGameTest >> testNoOpMovesAreNotRecorded [
	| game |
	game := self game.
	game clearAtRow: 1 column: 1.
	self assert: game moveCount equals: 0
]

{ #category : 'tests' }
NGSGameTest >> testRestart [
	| game |
	game := self game.
	game toggleFillAtRow: 2 column: 2.
	game restart.
	self assert: (game board atRow: 2 column: 2) equals: NGSUnknownCell new.
	self deny: game canUndo
]

{ #category : 'tests' }
NGSGameTest >> testSolving [
	| game |
	game := self game.
	self deny: game isSolved.
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p | game toggleFillAtRow: p first column: p second ].
	game toggleCrossAtRow: 1 column: 1.
	self assert: game isSolved
]

{ #category : 'tests' }
NGSGameTest >> testUndo [
	| game |
	game := self game.
	self deny: game canUndo.
	game toggleFillAtRow: 1 column: 1.
	game toggleCrossAtRow: 1 column: 1.
	self assert: game moveCount equals: 2.
	game undo.
	self assert: (game board atRow: 1 column: 1) equals: NGSFilledCell new.
	game undo.
	self assert: (game board atRow: 1 column: 1) equals: NGSUnknownCell new.
	game undo.
	self deny: game canUndo
]
