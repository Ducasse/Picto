"
I am a nonogram puzzle: a named grid picture together with the row and column clues derived from it.

Responsibility:
- keep the stored solution and derive the clues from it
- tell whether a line of a board satisfies its clue, and whether a whole board solves me
- tell whether my clues admit a single solution

Collaborators: NGClue for the clues, NGBoard for the player's grid, NGSolver to check uniqueness.

Public API and Key Messages:
- NGPuzzle class >> #named:fromStrings: and #named:solution: create me
- #rowClueAt:, #columnClueAt:, #width, #height, #isFilledAtRow:column:
- #isRowSatisfiedAt:by:, #isColumnSatisfiedAt:by:, #isSolvedBy:
- #hasUniqueSolution

	NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')

$# is a filled cell, any other character an empty one.

Internal Representation and Key Implementation Points.

Instance Variables
	name:			<String> the name of the puzzle, used as its identity in a library
	solution:		<Array of Arrays of Booleans> the rows of the picture, all of the same size
	rowClues:		<Array of NGClue> one clue per row
	columnClues:	<Array of NGClue> one clue per column

A board solves me when every line matches its clue, so any board satisfying the clues is accepted, not only the stored solution.
"
Class {
	#name : 'NGPuzzle',
	#superclass : 'Object',
	#instVars : [
		'name',
		'solution',
		'rowClues',
		'columnClues'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGPuzzle class >> named: aString fromStrings: aCollectionOfStrings [
	"Each string is a row; $# marks a filled cell, any other character an empty one"
	^ self
		named: aString
		solution: (aCollectionOfStrings collect: [ :line | line asArray collect: [ :char | char = $# ] ]) asArray
]

{ #category : 'instance creation' }
NGPuzzle class >> named: aString solution: anArrayOfRows [
	"anArrayOfRows is an Array of Arrays of Booleans, all of the same size"
	^ self new setName: aString solution: anArrayOfRows
]

{ #category : 'accessing' }
NGPuzzle >> columnClueAt: anIndex [
	^ columnClues at: anIndex
]

{ #category : 'accessing' }
NGPuzzle >> columnClues [
	^ columnClues
]

{ #category : 'testing' }
NGPuzzle >> hasUniqueSolution [
	^ ((NGSolver forPuzzle: self) solutionsUpTo: 2) size = 1
]

{ #category : 'accessing' }
NGPuzzle >> height [
	^ solution size
]

{ #category : 'testing' }
NGPuzzle >> isColumnSatisfiedAt: anIndex by: aBoard [

	^ (columnClues at: anIndex) isSatisfiedBy: (aBoard filledColumnAt: anIndex)
]

{ #category : 'solution' }
NGPuzzle >> isFilledAtRow: aRow column: aColumn [
	^ (solution at: aRow) at: aColumn
]

{ #category : 'testing' }
NGPuzzle >> isRowSatisfiedAt: anIndex by: aBoard [

	^ (rowClues at: anIndex) isSatisfiedBy: (aBoard filledRowAt: anIndex)
]

{ #category : 'testing' }
NGPuzzle >> isSolvedBy: aBoard [
	"Accept any board whose lines satisfy all clues, not only the stored solution"

	^ ((1 to: self height) allSatisfy: [ :index | self isRowSatisfiedAt: index by: aBoard ]) and: [
		  (1 to: self width) allSatisfy: [ :index | self isColumnSatisfiedAt: index by: aBoard ] ]
]

{ #category : 'accessing' }
NGPuzzle >> name [
	^ name
]

{ #category : 'printing' }
NGPuzzle >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(; nextPutAll: name; space; print: self width; nextPut: $x; print: self height; nextPut: $)
]

{ #category : 'accessing' }
NGPuzzle >> rowClueAt: anIndex [
	^ rowClues at: anIndex
]

{ #category : 'accessing' }
NGPuzzle >> rowClues [
	^ rowClues
]

{ #category : 'initialization' }
NGPuzzle >> setName: aString solution: anArrayOfRows [
	(anArrayOfRows collect: [ :row | row size ]) asSet size = 1
		ifFalse: [ self error: 'All rows of a puzzle must have the same size' ].
	name := aString.
	solution := anArrayOfRows.
	rowClues := solution collect: [ :row | NGClue fromLine: row ].
	columnClues := (1 to: self width) collect: [ :index | NGClue fromLine: (self solutionColumnAt: index) ]
]

{ #category : 'accessing' }
NGPuzzle >> solution [
	^ solution
]

{ #category : 'solution' }
NGPuzzle >> solutionColumnAt: anIndex [
	^ solution collect: [ :row | row at: anIndex ]
]

{ #category : 'accessing' }
NGPuzzle >> width [
	^ solution first size
]
