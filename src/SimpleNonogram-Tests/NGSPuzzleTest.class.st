Class {
	#name : 'NGSPuzzleTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-Core',
	#package : 'SimpleNonogram-Tests',
	#tag : 'Core'
}

{ #category : 'fixtures' }
NGSPuzzleTest >> plus [
	^ NGSPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')
]

{ #category : 'tests' }
NGSPuzzleTest >> testClues [
	| puzzle |
	puzzle := self plus.
	self assert: puzzle width equals: 3.
	self assert: puzzle height equals: 3.
	self assert: (puzzle rowClueAt: 2) equals: (NGSClue blocks: #(3)).
	self assert: (puzzle columnClueAt: 1) equals: (NGSClue blocks: #(1)).
	self assert: (puzzle isFilledAtRow: 1 column: 2)
]

{ #category : 'tests' }
NGSPuzzleTest >> testIsSolvedBy [
	| puzzle board |
	puzzle := self plus.
	board := NGSBoard for: puzzle.
	self deny: (puzzle isSolvedBy: board).
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p | board atRow: p first column: p second put: NGSFilledCell new ].
	self assert: (puzzle isSolvedBy: board)
]

{ #category : 'tests' }
NGSPuzzleTest >> testRaggedRowsAreRejected [
	self should: [ NGSPuzzle named: 'Bad' fromStrings: #('##' '#') ] raise: Error
]
