"
I test NGWonState.
"
Class {
	#name : 'NGWonStateTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGWonStateTest >> testIgnoresActions [
	| game |
	game := NGGame on: (NGPuzzle named: 'Dot' fromStrings: #('#.')).
	NGWonState new fillAtRow: 1 column: 1 in: game.
	NGWonState new crossAtRow: 1 column: 2 in: game.
	self assert: game board printString equals: '..'.
	self assert: ((NGWonState new statusTextIn: game) beginsWith: 'Solved in ')
]
