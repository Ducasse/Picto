"
I am the state of a cell the player wrongly tried to fill: the fill was refused and I reveal that the cell is empty.

Responsibility: stay unchanged whatever the action (I am locked); render as a red cross.

Collaborators: NGGame puts me on the board on an error; NGCellElement displays me.

Public API and Key Messages: #afterFill, #afterCross, #afterClear (all answer myself), #renderOn:

	NGRevealedEmptyCell new afterClear >>> NGRevealedEmptyCell new

Internal Representation and Key Implementation Points.

I have no instance variables.
"
Class {
	#name : 'NGRevealedEmptyCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterClear [
	^ self
]

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterCross [
	^ self
]

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterFill [
	^ self
]

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterWin [
	^ NGUnknownCell new
]

{ #category : 'printing' }
NGRevealedEmptyCell >> character [
	^ $!
]

{ #category : 'rendering' }
NGRevealedEmptyCell >> renderOn: aCellElement [
	aCellElement showRevealedEmpty
]
