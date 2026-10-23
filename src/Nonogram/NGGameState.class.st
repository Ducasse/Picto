"
I am the abstract state of an NGGame. My subclasses are NGPlayingState, NGWonState and NGLostState. The game delegates the player's actions to me, so a finished game ignores them without testing flags.
"
Class {
	#name : 'NGGameState',
	#superclass : 'Object',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'actions' }
NGGameState >> clearAtRow: aRow column: aColumn in: aGame [
	^ self subclassResponsibility
]

{ #category : 'actions' }
NGGameState >> crossAtRow: aRow column: aColumn in: aGame [
	^ self subclassResponsibility
]

{ #category : 'actions' }
NGGameState >> fillAtRow: aRow column: aColumn in: aGame [
	^ self subclassResponsibility
]

{ #category : 'printing' }
NGGameState >> statusTextIn: aGame [
	^ self subclassResponsibility
]
