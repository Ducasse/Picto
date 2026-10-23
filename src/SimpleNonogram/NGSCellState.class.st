"
I am the abstract state of a cell on a player's board. My subclasses are NGSUnknownCell, NGSFilledCell and NGSCrossedCell. States are stateless and compared by class, so behavior is chosen by polymorphism rather than by testing.
"
Class {
	#name : 'NGSCellState',
	#superclass : 'Object',
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'comparing' }
NGSCellState >> = anObject [
	^ self class = anObject class
]

{ #category : 'transitions' }
NGSCellState >> afterCross [
	"Return the state reached when the player uses the cross action on me"
	^ self subclassResponsibility
]

{ #category : 'transitions' }
NGSCellState >> afterFill [
	"Return the state reached when the player uses the fill action on me"
	^ self subclassResponsibility
]

{ #category : 'printing' }
NGSCellState >> character [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
NGSCellState >> hash [
	^ self class hash
]

{ #category : 'testing' }
NGSCellState >> isFilled [
	^ false
]

{ #category : 'printing' }
NGSCellState >> printOn: aStream [
	aStream nextPut: self character
]
