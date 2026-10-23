"
I am a nonogram puzzle. I keep the solution as an Array of rows of Booleans and derive the row and column clues from it.

	NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')

# is filled, any other character is empty.
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

{ #category : 'accessing' }
NGPuzzle >> height [
	^ solution size
]

{ #category : 'solution' }
NGPuzzle >> isFilledAtRow: aRow column: aColumn [
	^ (solution at: aRow) at: aColumn
]

{ #category : 'solution' }
NGPuzzle >> isSolvedBy: aBoard [
	"Accept any board whose lines satisfy all clues, not only the stored solution"
	^ ((1 to: self height) allSatisfy: [ :index | (rowClues at: index) isSatisfiedBy: (aBoard filledRowAt: index) ])
		and: [ (1 to: self width) allSatisfy: [ :index | (columnClues at: index) isSatisfiedBy: (aBoard filledColumnAt: index) ] ]
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

{ #category : 'solution' }
NGPuzzle >> solutionColumnAt: anIndex [
	^ solution collect: [ :row | row at: anIndex ]
]

{ #category : 'accessing' }
NGPuzzle >> width [
	^ solution first size
]
