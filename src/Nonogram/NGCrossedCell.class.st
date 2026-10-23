"
I am the state of a cell the player marked as probably empty. A cross is only a hypothesis and is never judged against the solution.

Responsibility: become filled on a fill and go back to unknown on a cross; render as a cross.

Collaborators: NGCellState, NGCellElement.

Public API and Key Messages: #afterFill, #afterCross, #renderOn:

	NGCrossedCell new afterCross >>> NGUnknownCell new

Internal Representation and Key Implementation Points.

I have no instance variables.
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

{ #category : 'transitions' }
NGCrossedCell >> afterWin [
	^ NGUnknownCell new
]

{ #category : 'printing' }
NGCrossedCell >> character [
	^ $x
]
