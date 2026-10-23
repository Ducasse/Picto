"
I test NGPlayingState.
"
Class {
	#name : 'NGPlayingStateTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGPlayingStateTest >> testForwardsActions [
	| game |
	game := NGGame on: (NGPuzzle named: 'Dot' fromStrings: #('#.')).
	NGPlayingState new crossAtRow: 1 column: 2 in: game.
	self assert: (game board atRow: 1 column: 2) equals: NGCrossedCell new.
	self assert: (NGPlayingState new statusTextIn: game) equals: ''
]
