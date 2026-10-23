"
I represent a cell the player has filled (painted).
"
Class {
	#name : 'NGFilledCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGFilledCell >> afterCross [
	^ NGCrossedCell new
]

{ #category : 'transitions' }
NGFilledCell >> afterFill [
	^ NGUnknownCell new
]

{ #category : 'printing' }
NGFilledCell >> character [
	^ $#
]

{ #category : 'testing' }
NGFilledCell >> isFilled [
	^ true
]
