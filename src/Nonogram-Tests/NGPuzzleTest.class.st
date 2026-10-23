Class {
	#name : 'NGPuzzleTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'fixtures' }
NGPuzzleTest >> plus [
	^ NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')
]

{ #category : 'tests' }
NGPuzzleTest >> testClues [
	| puzzle |
	puzzle := self plus.
	self assert: puzzle width equals: 3.
	self assert: puzzle height equals: 3.
	self assert: (puzzle rowClueAt: 2) equals: (NGClue blocks: #(3)).
	self assert: (puzzle columnClueAt: 1) equals: (NGClue blocks: #(1)).
	self assert: (puzzle isFilledAtRow: 1 column: 2)
]

{ #category : 'tests' }
NGPuzzleTest >> testIsSolvedBy [
	| puzzle board |
	puzzle := self plus.
	board := NGBoard for: puzzle.
	self deny: (puzzle isSolvedBy: board).
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p | board atRow: p first column: p second put: NGFilledCell new ].
	self assert: (puzzle isSolvedBy: board)
]

{ #category : 'tests' }
NGPuzzleTest >> testRaggedRowsAreRejected [
	self should: [ NGPuzzle named: 'Bad' fromStrings: #('##' '#') ] raise: Error
]
