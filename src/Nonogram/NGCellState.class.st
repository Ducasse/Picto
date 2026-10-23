"
I am the abstract state of a cell on a player's board. My subclasses are NGUnknownCell, NGFilledCell and NGCrossedCell. States are stateless and compared by class, so behavior is chosen by polymorphism rather than by testing.
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
NGCellState >> afterCross [
	"Return the state reached when the player uses the cross action on me"
	^ self subclassResponsibility
]

{ #category : 'transitions' }
NGCellState >> afterFill [
	"Return the state reached when the player uses the fill action on me"
	^ self subclassResponsibility
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
