"
I am the state of a game where the player lost all lives: I ignore the player's actions.
"
Class {
	#name : 'NGLostState',
	#superclass : 'NGGameState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'actions' }
NGLostState >> clearAtRow: aRow column: aColumn in: aGame [
]

{ #category : 'actions' }
NGLostState >> crossAtRow: aRow column: aColumn in: aGame [
]

{ #category : 'actions' }
NGLostState >> fillAtRow: aRow column: aColumn in: aGame [
]

{ #category : 'printing' }
NGLostState >> statusTextIn: aGame [
	^ 'Game over'
]
