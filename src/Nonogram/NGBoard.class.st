"
I am the player's board: a grid of NGCellState, all unknown at start. Positions are given as row and column, both 1-based.
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

{ #category : 'accessing' }
NGBoard >> width [
	^ rows first size
]
