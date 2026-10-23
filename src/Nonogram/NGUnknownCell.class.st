"
I represent a cell the player has not decided on yet.
"
Class {
	#name : 'NGUnknownCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGUnknownCell >> afterCross [
	^ NGCrossedCell new
]

{ #category : 'transitions' }
NGUnknownCell >> afterFill [
	^ NGFilledCell new
]

{ #category : 'printing' }
NGUnknownCell >> character [
	^ $.
]
