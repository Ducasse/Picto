"
I test NGSolver.
"
Class {
	#name : 'NGSolverTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'helpers' }
NGSolverTest >> diagonal [
	^ NGPuzzle named: 'Diagonal' fromStrings: #('#.' '.#')
]

{ #category : 'tests' }
NGSolverTest >> testAmbiguousPuzzleHasTwoSolutions [
	| solutions |
	solutions := (NGSolver forPuzzle: self diagonal) solutionsUpTo: 5.
	self assert: solutions asSet equals: (Set with: #(#(true false) #(false true)) with: #(#(false true) #(true false)))
]

{ #category : 'tests' }
NGSolverTest >> testEmptyClues [
	self assert: ((NGSolver rowClues: { NGClue blocks: #() } columnClues: { NGClue blocks: #(). NGClue blocks: #() }) solutionsUpTo: 2) equals: #(#(#(false false)))
]

{ #category : 'tests' }
NGSolverTest >> testStopsAtRequestedCount [
	self assert: ((NGSolver forPuzzle: self diagonal) solutionsUpTo: 1) size equals: 1
]

{ #category : 'tests' }
NGSolverTest >> testUniquePuzzleHasOneSolution [
	| puzzle solutions |
	puzzle := NGPuzzles plus.
	solutions := (NGSolver forPuzzle: puzzle) solutionsUpTo: 2.
	self assert: solutions size equals: 1.
	self assert: solutions first equals: puzzle solution
]
