"
I am the player's board: a grid of NGSCellState, all unknown at start. Positions are given as row and column, both 1-based.
"
Class {
	#name : 'NGSBoard',
	#superclass : 'Object',
	#instVars : [
		'rows'
	],
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGSBoard class >> for: aPuzzle [
	^ self height: aPuzzle height width: aPuzzle width
]

{ #category : 'instance creation' }
NGSBoard class >> height: aHeight width: aWidth [
	^ self new setHeight: aHeight width: aWidth
]

{ #category : 'accessing' }
NGSBoard >> atRow: aRow column: aColumn [
	^ (rows at: aRow) at: aColumn
]

{ #category : 'accessing' }
NGSBoard >> atRow: aRow column: aColumn put: aCellState [
	^ (rows at: aRow) at: aColumn put: aCellState
]

{ #category : 'accessing' }
NGSBoard >> columnAt: anIndex [
	^ rows collect: [ :row | row at: anIndex ]
]

{ #category : 'accessing' }
NGSBoard >> filledColumnAt: anIndex [
	^ (self columnAt: anIndex) collect: [ :cell | cell isFilled ]
]

{ #category : 'accessing' }
NGSBoard >> filledRowAt: anIndex [
	^ (rows at: anIndex) collect: [ :cell | cell isFilled ]
]

{ #category : 'accessing' }
NGSBoard >> height [
	^ rows size
]

{ #category : 'printing' }
NGSBoard >> printOn: aStream [
	rows
		do: [ :row | row do: [ :cell | aStream nextPut: cell character ] ]
		separatedBy: [ aStream cr ]
]

{ #category : 'operations' }
NGSBoard >> reset [
	self setHeight: self height width: self width
]

{ #category : 'accessing' }
NGSBoard >> rowAt: anIndex [
	^ (rows at: anIndex) copy
]

{ #category : 'initialization' }
NGSBoard >> setHeight: aHeight width: aWidth [
	rows := (1 to: aHeight) collect: [ :each | Array new: aWidth withAll: NGSUnknownCell new ]
]

{ #category : 'accessing' }
NGSBoard >> width [
	^ rows first size
]
