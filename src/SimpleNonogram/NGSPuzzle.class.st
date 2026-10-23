"
I am a nonogram puzzle. I keep the solution as an Array of rows of Booleans and derive the row and column clues from it.

	NGSPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')

# is filled, any other character is empty.
"
Class {
	#name : 'NGSPuzzle',
	#superclass : 'Object',
	#instVars : [
		'name',
		'solution',
		'rowClues',
		'columnClues'
	],
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGSPuzzle class >> named: aString fromStrings: aCollectionOfStrings [
	"Each string is a row; $# marks a filled cell, any other character an empty one"
	^ self
		named: aString
		solution: (aCollectionOfStrings collect: [ :line | line asArray collect: [ :char | char = $# ] ]) asArray
]

{ #category : 'instance creation' }
NGSPuzzle class >> named: aString solution: anArrayOfRows [
	"anArrayOfRows is an Array of Arrays of Booleans, all of the same size"
	^ self new setName: aString solution: anArrayOfRows
]

{ #category : 'accessing' }
NGSPuzzle >> columnClueAt: anIndex [
	^ columnClues at: anIndex
]

{ #category : 'accessing' }
NGSPuzzle >> columnClues [
	^ columnClues
]

{ #category : 'accessing' }
NGSPuzzle >> height [
	^ solution size
]

{ #category : 'solution' }
NGSPuzzle >> isFilledAtRow: aRow column: aColumn [
	^ (solution at: aRow) at: aColumn
]

{ #category : 'solution' }
NGSPuzzle >> isSolvedBy: aBoard [
	"Accept any board whose lines satisfy all clues, not only the stored solution"
	^ ((1 to: self height) allSatisfy: [ :index | (rowClues at: index) isSatisfiedBy: (aBoard filledRowAt: index) ])
		and: [ (1 to: self width) allSatisfy: [ :index | (columnClues at: index) isSatisfiedBy: (aBoard filledColumnAt: index) ] ]
]

{ #category : 'accessing' }
NGSPuzzle >> name [
	^ name
]

{ #category : 'printing' }
NGSPuzzle >> printOn: aStream [
	super printOn: aStream.
	aStream nextPut: $(; nextPutAll: name; space; print: self width; nextPut: $x; print: self height; nextPut: $)
]

{ #category : 'accessing' }
NGSPuzzle >> rowClueAt: anIndex [
	^ rowClues at: anIndex
]

{ #category : 'accessing' }
NGSPuzzle >> rowClues [
	^ rowClues
]

{ #category : 'initialization' }
NGSPuzzle >> setName: aString solution: anArrayOfRows [
	(anArrayOfRows collect: [ :row | row size ]) asSet size = 1
		ifFalse: [ self error: 'All rows of a puzzle must have the same size' ].
	name := aString.
	solution := anArrayOfRows.
	rowClues := solution collect: [ :row | NGSClue fromLine: row ].
	columnClues := (1 to: self width) collect: [ :index | NGSClue fromLine: (self solutionColumnAt: index) ]
]

{ #category : 'solution' }
NGSPuzzle >> solutionColumnAt: anIndex [
	^ solution collect: [ :row | row at: anIndex ]
]

{ #category : 'accessing' }
NGSPuzzle >> width [
	^ solution first size
]
