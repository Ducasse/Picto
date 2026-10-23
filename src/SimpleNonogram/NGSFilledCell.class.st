"
I represent a cell the player has filled (painted).
"
Class {
	#name : 'NGSFilledCell',
	#superclass : 'NGSCellState',
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGSFilledCell >> afterCross [
	^ NGSCrossedCell new
]

{ #category : 'transitions' }
NGSFilledCell >> afterFill [
	^ NGSUnknownCell new
]

{ #category : 'printing' }
NGSFilledCell >> character [
	^ $#
]

{ #category : 'testing' }
NGSFilledCell >> isFilled [
	^ true
]
