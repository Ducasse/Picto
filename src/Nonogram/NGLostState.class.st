"
I am the state of a game where the player lost all lives.

Responsibility: ignore the player's actions; answer 'Game over' as status.

Collaborators: NGGame.

Public API and Key Messages: #statusTextIn:

	NGLostState new statusTextIn: aGame >>> 'Game over'

Internal Representation and Key Implementation Points.

I have no instance variables.
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

{ #category : 'rendering' }
NGLostState >> showOutcomeOn: aGameElement for: aGame [
	aGameElement showLost
]

{ #category : 'printing' }
NGLostState >> statusTextIn: aGame [
	^ 'Game over'
]
