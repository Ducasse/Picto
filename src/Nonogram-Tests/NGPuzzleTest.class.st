"
I test NGPuzzle.
"
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
NGPuzzleTest >> testHasUniqueSolution [
	self assert: NGPuzzles plus hasUniqueSolution.
	self deny: (NGPuzzle named: 'Diagonal' fromStrings: #('#.' '.#')) hasUniqueSolution
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
NGPuzzleTest >> testLineSatisfaction [

	| puzzle board |
	puzzle := NGPuzzle named: 'Plus' fromStrings: #( '.#.' '###' '.#.' ).
	board := NGBoard for: puzzle.
	self deny: (puzzle isRowSatisfiedAt: 1 by: board).
	board atRow: 1 column: 2 put: NGFilledCell new.
	self assert: (puzzle isRowSatisfiedAt: 1 by: board).
	self deny: (puzzle isColumnSatisfiedAt: 2 by: board).
	board atRow: 2 column: 2 put: NGFilledCell new.
	board atRow: 3 column: 2 put: NGFilledCell new.
	self assert: (puzzle isColumnSatisfiedAt: 2 by: board).
	board atRow: 1 column: 1 put: NGFilledCell new.
	self deny: (puzzle isRowSatisfiedAt: 1 by: board)
]

{ #category : 'tests' }
NGPuzzleTest >> testRaggedRowsAreRejected [
	self should: [ NGPuzzle named: 'Bad' fromStrings: #('##' '#') ] raise: Error
]
