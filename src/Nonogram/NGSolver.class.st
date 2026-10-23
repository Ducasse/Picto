"
I find the solutions of a nonogram from its clues alone, without looking at any stored solution.

Responsibility:
- enumerate the grids satisfying a set of row and column clues, up to a requested count

Collaborators: NGClue for the row placements and the column prefix test; NGPuzzle and NGPuzzleLibrary use me to check uniqueness.

Public API and Key Messages:
- NGSolver class >> #forPuzzle: and #rowClues:columnClues: create me
- #solutionsUpTo:

	((NGSolver forPuzzle: NGPuzzles plus) solutionsUpTo: 2) size >>> 1

Internal Representation and Key Implementation Points.

Instance Variables
	rowClues:		<Array of NGClue> the clues of the rows
	columnClues:	<Array of NGClue> the clues of the columns
	rowPlacements:	<Array of Arrays> for each row, every line satisfying its clue

I backtrack row by row over the placements, pruning as soon as a column prefix cannot be completed, and stop once enough solutions are found.
"
Class {
	#name : 'NGSolver',
	#superclass : 'Object',
	#instVars : [
		'rowClues',
		'columnClues',
		'rowPlacements'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGSolver class >> forPuzzle: aPuzzle [
	^ self rowClues: aPuzzle rowClues columnClues: aPuzzle columnClues
]

{ #category : 'instance creation' }
NGSolver class >> rowClues: someRowClues columnClues: someColumnClues [
	^ self new setRowClues: someRowClues columnClues: someColumnClues
]

{ #category : 'private' }
NGSolver >> columnsAcceptRows: someRows [
	^ (1 to: self width) allSatisfy: [ :index |
		(columnClues at: index)
			acceptsPrefix: (someRows collect: [ :row | row at: index ]) asArray
			inLength: self height ]
]

{ #category : 'private' }
NGSolver >> extend: someRows into: solutions upTo: aNumber [
	"Try each placement of the next row, keeping only those leaving every column completable"
	someRows size = self height ifTrue: [ ^ solutions add: someRows asArray ].
	(rowPlacements at: someRows size + 1) do: [ :placement |
		solutions size >= aNumber ifTrue: [ ^ self ].
		someRows addLast: placement.
		(self columnsAcceptRows: someRows) ifTrue: [ self extend: someRows into: solutions upTo: aNumber ].
		someRows removeLast ]
]

{ #category : 'accessing' }
NGSolver >> height [
	^ rowClues size
]

{ #category : 'initialization' }
NGSolver >> setRowClues: someRowClues columnClues: someColumnClues [
	rowClues := someRowClues.
	columnClues := someColumnClues.
	rowPlacements := rowClues collect: [ :clue | clue placementsInLength: self width ]
]

{ #category : 'solving' }
NGSolver >> solutionsUpTo: aNumber [
	"Answer at most aNumber grids (Arrays of rows of Booleans) satisfying all the clues"
	| solutions |
	solutions := OrderedCollection new.
	self extend: OrderedCollection new into: solutions upTo: aNumber.
	^ solutions asArray
]

{ #category : 'accessing' }
NGSolver >> width [
	^ columnClues size
]
