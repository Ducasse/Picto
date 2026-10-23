"
I am the state of a cell the player has not decided on yet.

Responsibility: become filled on a fill and crossed on a cross; render as a blank cell.

Collaborators: NGCellState, NGCellElement.

Public API and Key Messages: #afterFill, #afterCross, #renderOn:

	NGUnknownCell new afterCross >>> NGCrossedCell new

Internal Representation and Key Implementation Points.

I have no instance variables.
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
