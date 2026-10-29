"
I am the player's board: a grid of cell states, all unknown at start.

## Responsibility:

- I store and answer the state of each cell.
- I answer the rows and columns of the grid, and which of their cells are filled.
- I can be reset to an all unknown grid.

## Collaborators:

- `NGCellState` subclasses are the values I hold.
- `NGGame` changes me when the player acts.
- `NGPuzzle` judges me against its clues.

## Public API and Key Messages

- `NGBoard class >> #for:` (sized after a puzzle) and `NGBoard class >> #height:width:` create instances.
- `#atRow:column:` and `#atRow:column:put:` read and write a cell.
- `#filledRowAt:` and `#filledColumnAt:` answer a line as Booleans.
- `#reset` makes every cell unknown again.

```
(NGBoard height: 2 width: 3) atRow: 1 column: 2 put: NGFilledCell new
```

## Internal Representation

- `rows`: <Array of Arrays of `NGCellState`> the grid; positions are 1-based row and column.
"
Class {
	#name : 'NGBoard',
	#superclass : 'Object',
	#instVars : [
		'rows'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGBoard class >> for: aPuzzle [
	^ self height: aPuzzle height width: aPuzzle width
]

{ #category : 'instance creation' }
NGBoard class >> height: aHeight width: aWidth [
	^ self new setHeight: aHeight width: aWidth
]

{ #category : 'accessing' }
NGBoard >> atRow: aRow column: aColumn [
	^ (rows at: aRow) at: aColumn
]

{ #category : 'accessing' }
NGBoard >> atRow: aRow column: aColumn put: aCellState [
	^ (rows at: aRow) at: aColumn put: aCellState
]

{ #category : 'accessing' }
NGBoard >> columnAt: anIndex [
	^ rows collect: [ :row | row at: anIndex ]
]

{ #category : 'accessing' }
NGBoard >> filledColumnAt: anIndex [
	^ (self columnAt: anIndex) collect: [ :cell | cell isFilled ]
]

{ #category : 'accessing' }
NGBoard >> filledRowAt: anIndex [
	^ (rows at: anIndex) collect: [ :cell | cell isFilled ]
]

{ #category : 'accessing' }
NGBoard >> height [
	^ rows size
]

{ #category : 'printing' }
NGBoard >> printOn: aStream [
	rows
		do: [ :row | row do: [ :cell | aStream nextPut: cell character ] ]
		separatedBy: [ aStream cr ]
]

{ #category : 'operations' }
NGBoard >> reset [
	self setHeight: self height width: self width
]

{ #category : 'accessing' }
NGBoard >> rowAt: anIndex [
	^ (rows at: anIndex) copy
]

{ #category : 'initialization' }
NGBoard >> setHeight: aHeight width: aWidth [
	rows := (1 to: aHeight) collect: [ :each | Array new: aWidth withAll: NGUnknownCell new ]
]

{ #category : 'actions' }
NGBoard >> showSolved [
	"Clear every cross so that only the picture remains"
	rows do: [ :row | row doWithIndex: [ :cell :index | row at: index put: cell afterWin ] ]
]

{ #category : 'accessing' }
NGBoard >> width [
	^ rows first size
]
