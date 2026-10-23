"
I represent a cell the player has marked as certainly empty.
"
Class {
	#name : 'NGSCrossedCell',
	#superclass : 'NGSCellState',
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGSCrossedCell >> afterCross [
	^ NGSUnknownCell new
]

{ #category : 'transitions' }
NGSCrossedCell >> afterFill [
	^ NGSFilledCell new
]

{ #category : 'printing' }
NGSCrossedCell >> character [
	^ $x
]
