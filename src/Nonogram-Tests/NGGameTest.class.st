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
NGGameTest >> testCrossesAreNeverErrors [
	| game |
	game := self game.
	game toggleCrossAtRow: 2 column: 2.
	self assert: (game board atRow: 2 column: 2) equals: NGCrossedCell new.
	self assert: game livesLeft equals: 3
]

{ #category : 'tests' }
NGGameTest >> testCustomLives [
	self assert: (NGGame on: self game puzzle lives: 5) livesLeft equals: 5
]

{ #category : 'tests' }
NGGameTest >> testLineSatisfaction [

	| game |
	game := self game.
	self deny: (game isRowSatisfiedAt: 1).
	game toggleFillAtRow: 1 column: 2.
	self assert: (game isRowSatisfiedAt: 1).
	self deny: (game isColumnSatisfiedAt: 2)
]

{ #category : 'tests' }
NGGameTest >> testLosingAllLivesEndsTheGame [
	| game |
	game := self game.
	#(#(1 1) #(1 3) #(3 1)) do: [ :p | game toggleFillAtRow: p first column: p second ].
	self assert: game livesLeft equals: 0.
	self assert: game statusText equals: 'Game over'.
	game toggleFillAtRow: 2 column: 2.
	self assert: (game board atRow: 2 column: 2) equals: NGUnknownCell new
]

{ #category : 'tests' }
NGGameTest >> testPrintLives [
	| game |
	game := self game.
	self assert: game printLives equals: (String new: 3 withAll: (Character value: 16r2665)).
	game toggleFillAtRow: 1 column: 1.
	self assert: game printLives equals: (String new: 2 withAll: (Character value: 16r2665)) , (String with: (Character value: 16r2661))
]

{ #category : 'tests' }
NGGameTest >> testRestart [
	| game |
	game := self game.
	game toggleFillAtRow: 2 column: 2.
	game toggleFillAtRow: 1 column: 1.
	game restart.
	self assert: (game board atRow: 2 column: 2) equals: NGUnknownCell new.
	self assert: (game board atRow: 1 column: 1) equals: NGUnknownCell new.
	self assert: game livesLeft equals: 3.
	self assert: game statusText equals: ''
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
NGGameTest >> testTimerRunsFromFirstMoveUntilSolved [
	| time game |
	time := DateAndTime year: 2026 month: 1 day: 1.
	game := NGGame on: (NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')) lives: 3 timer: (NGTimer clock: [ time ]).
	time := time + 10 seconds.
	self assert: game timer elapsed equals: Duration zero.
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p |
		game toggleFillAtRow: p first column: p second.
		time := time + 1 second ].
	self assert: game isSolved.
	time := time + 100 seconds.
	self assert: game timer elapsed equals: 4 seconds.
	self assert: game statusText equals: 'Solved in 00:04'.
	game restart.
	self assert: game timer elapsed equals: Duration zero
]

{ #category : 'tests' }
NGGameTest >> testWonGameIgnoresActions [
	| game |
	game := self game.
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p | game toggleFillAtRow: p first column: p second ].
	game toggleFillAtRow: 2 column: 2.
	self assert: (game board atRow: 2 column: 2) equals: NGFilledCell new
]

{ #category : 'tests' }
NGGameTest >> testWrongFillIsRevealedAndCostsALife [
	| game |
	game := self game.
	game toggleFillAtRow: 1 column: 1.
	self assert: (game board atRow: 1 column: 1) equals: NGRevealedEmptyCell new.
	self assert: game livesLeft equals: 2.
	game toggleFillAtRow: 1 column: 1.
	game toggleCrossAtRow: 1 column: 1.
	game clearAtRow: 1 column: 1.
	self assert: (game board atRow: 1 column: 1) equals: NGRevealedEmptyCell new.
	self assert: game livesLeft equals: 2
]

{ #category : 'tests' }
NGGameTest >> testWrongFillOnCrossedCellIsAnError [
	| game |
	game := self game.
	game toggleCrossAtRow: 1 column: 1.
	game toggleFillAtRow: 1 column: 1.
	self assert: (game board atRow: 1 column: 1) equals: NGRevealedEmptyCell new.
	self assert: game livesLeft equals: 2
]
