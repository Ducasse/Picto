"
I represent a cell the player has not decided on yet.
"
Class {
	#name : 'NGSUnknownCell',
	#superclass : 'NGSCellState',
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGSUnknownCell >> afterCross [
	^ NGSCrossedCell new
]

{ #category : 'transitions' }
NGSUnknownCell >> afterFill [
	^ NGSFilledCell new
]

{ #category : 'printing' }
NGSUnknownCell >> character [
	^ $.
]
