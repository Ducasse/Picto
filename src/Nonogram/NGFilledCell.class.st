"
I am the state of a cell the player has filled.

Responsibility: count as filled; go back to unknown on a fill and become crossed on a cross; render as a black cell.

Collaborators: NGCellState, NGCellElement.

Public API and Key Messages: #isFilled, #afterFill, #afterCross, #renderOn:

	NGFilledCell new isFilled >>> true

Internal Representation and Key Implementation Points.

I have no instance variables.
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
