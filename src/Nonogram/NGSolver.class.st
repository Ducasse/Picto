"
I find the solutions of a nonogram from its clues alone, without looking at any stored solution.

Responsibility:
- enumerate the grids satisfying a set of row and column clues, up to a requested count

Collaborators: NGClue for the placements of each line; NGPuzzle and NGPuzzleLibrary use me to check uniqueness.

Public API and Key Messages:
- NGSolver class >> #forPuzzle: and #rowClues:columnClues: create me
- #solutionsUpTo:

	((NGSolver forPuzzle: NGPuzzles plus) solutionsUpTo: 2) size >>> 1

Internal Representation and Key Implementation Points.

Instance Variables
	rowClues:			<Array of NGClue> the clues of the rows
	columnClues:		<Array of NGClue> the clues of the columns
	rowPlacements:		<Array of Arrays> for each row, every line satisfying its clue
	columnPlacements:	<Array of Arrays> for each column, every line satisfying its clue

I search on a grid of #unknown, #filled and #empty cells. I first propagate: each line keeps only the placements fitting its known cells, and the cells on which all of them agree become known, until nothing changes. A line without placement is a contradiction. If rows are still open, I guess each placement of the row with the fewest ones and search again. I stop once enough solutions are found; 20 x 20 puzzles are checked in a few milliseconds.
"
Class {
	#name : 'NGSolver',
	#superclass : 'Object',
	#instVars : [
		'rowClues',
		'columnClues',
		'rowPlacements',
		'columnPlacements'
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
NGSolver >> cellFor: aBoolean [
	^ aBoolean
		ifTrue: [ #filled ]
		ifFalse: [ #empty ]
]

{ #category : 'accessing' }
NGSolver >> height [
	^ rowClues size
]

{ #category : 'private' }
NGSolver >> placement: aPlacement fits: aLine [
	^ (1 to: aPlacement size) allSatisfy: [ :index |
		(aLine at: index) = #unknown or: [ (aLine at: index) = (self cellFor: (aPlacement at: index)) ] ]
]

{ #category : 'private' }
NGSolver >> placements: somePlacements agreeAt: anIndex [
	| value |
	value := somePlacements first at: anIndex.
	^ somePlacements allSatisfy: [ :each | (each at: anIndex) = value ]
]

{ #category : 'private' }
NGSolver >> propagate: aGrid rows: rows columns: columns [
	"Keep the placements fitting the known cells and fix the cells on which they all agree, until nothing changes. Answer false on a contradiction"
	| changed |
	changed := true.
	[ changed ] whileTrue: [
		changed := false.
		1 to: self height do: [ :rowIndex |
			| line |
			line := aGrid at: rowIndex.
			rows at: rowIndex put: ((rows at: rowIndex) select: [ :placement | self placement: placement fits: line ]).
			(rows at: rowIndex) ifEmpty: [ ^ false ].
			1 to: self width do: [ :columnIndex |
				((line at: columnIndex) = #unknown and: [ self placements: (rows at: rowIndex) agreeAt: columnIndex ])
					ifTrue: [
						line at: columnIndex put: (self cellFor: ((rows at: rowIndex) first at: columnIndex)).
						changed := true ] ] ].
		1 to: self width do: [ :columnIndex |
			| line |
			line := aGrid collect: [ :row | row at: columnIndex ].
			columns at: columnIndex put: ((columns at: columnIndex) select: [ :placement | self placement: placement fits: line ]).
			(columns at: columnIndex) ifEmpty: [ ^ false ].
			1 to: self height do: [ :rowIndex |
				((line at: rowIndex) = #unknown and: [ self placements: (columns at: columnIndex) agreeAt: rowIndex ])
					ifTrue: [
						(aGrid at: rowIndex) at: columnIndex put: (self cellFor: ((columns at: columnIndex) first at: rowIndex)).
						changed := true ] ] ] ].
	^ true
]

{ #category : 'private' }
NGSolver >> search: aGrid rows: rowCandidates columns: columnCandidates into: solutions upTo: aNumber [
	"Deduce what the lines force, then guess among the placements of the least open row"
	| rows columns openRows branchIndex |
	rows := rowCandidates copy.
	columns := columnCandidates copy.
	(self propagate: aGrid rows: rows columns: columns) ifFalse: [ ^ self ].
	openRows := (1 to: self height) select: [ :index | (rows at: index) size > 1 ].
	openRows ifEmpty: [ ^ solutions add: (rows collect: [ :each | each first ]) ].
	branchIndex := openRows detectMin: [ :index | (rows at: index) size ].
	(rows at: branchIndex) do: [ :placement |
		| grid |
		solutions size >= aNumber ifTrue: [ ^ self ].
		grid := aGrid collect: [ :row | row copy ].
		grid at: branchIndex put: (placement collect: [ :filled | self cellFor: filled ]).
		self search: grid rows: rows columns: columns into: solutions upTo: aNumber ]
]

{ #category : 'initialization' }
NGSolver >> setRowClues: someRowClues columnClues: someColumnClues [
	rowClues := someRowClues.
	columnClues := someColumnClues.
	rowPlacements := rowClues collect: [ :clue | clue placementsInLength: self width ].
	columnPlacements := columnClues collect: [ :clue | clue placementsInLength: self height ]
]

{ #category : 'solving' }
NGSolver >> solutionsUpTo: aNumber [
	"Answer at most aNumber grids (Arrays of rows of Booleans) satisfying all the clues"
	| solutions |
	solutions := OrderedCollection new.
	self
		search: ((1 to: self height) collect: [ :each | Array new: self width withAll: #unknown ])
		rows: rowPlacements
		columns: columnPlacements
		into: solutions
		upTo: aNumber.
	^ solutions asArray
]

{ #category : 'accessing' }
NGSolver >> width [
	^ columnClues size
]
