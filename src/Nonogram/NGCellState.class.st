"
I am the abstract state of a cell on a player's board.

Responsibility:
- answer the state reached after a fill, cross or clear action
- tell whether I count as filled
- render myself on a cell element

Collaborators: my subclasses NGUnknownCell, NGFilledCell, NGCrossedCell and NGRevealedEmptyCell; NGBoard stores me; NGCellElement displays me.

Public API and Key Messages:
- #afterFill, #afterCross, #afterClear, #isFilled, #renderOn:, #character

	NGUnknownCell new afterFill >>> NGFilledCell new

Internal Representation and Key Implementation Points.

I have no instance variables. States are compared by class, so behavior is chosen by polymorphism rather than by testing.
"
Class {
	#name : 'NGCellState',
	#superclass : 'Object',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'comparing' }
NGCellState >> = anObject [
	^ self class = anObject class
]

{ #category : 'transitions' }
NGCellState >> afterClear [
	"Return the state reached when the player clears me"
	^ NGUnknownCell new
]

{ #category : 'transitions' }
NGCellState >> afterCross [
	"Return the state reached when the player uses the cross action on me"
	^ self subclassResponsibility
]

{ #category : 'transitions' }
NGCellState >> afterFill [
	"Return the state reached when the player uses the fill action on me"
	^ self subclassResponsibility
]

{ #category : 'transitions' }
NGCellState >> afterWin [
	"Return the state shown once the puzzle is solved: only filled cells remain visible"
	^ self
]

{ #category : 'printing' }
NGCellState >> character [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
NGCellState >> hash [
	^ self class hash
]

{ #category : 'testing' }
NGCellState >> isFilled [
	^ false
]

{ #category : 'printing' }
NGCellState >> printOn: aStream [
	aStream nextPut: self character
]
