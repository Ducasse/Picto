"
I represent a cell the player has marked as certainly empty.
"
Class {
	#name : 'NGCrossedCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGCrossedCell >> afterCross [
	^ NGUnknownCell new
]

{ #category : 'transitions' }
NGCrossedCell >> afterFill [
	^ NGFilledCell new
]

{ #category : 'printing' }
NGCrossedCell >> character [
	^ $x
]
