"
I am the state of a solved game.

Responsibility: ignore the player's actions; answer a status with the solving time.

Collaborators: NGGame, NGTimer.

Public API and Key Messages: #statusTextIn: answers 'Solved in mm:ss'

	NGWonState new statusTextIn: aGame

Internal Representation and Key Implementation Points.

I have no instance variables.
"
Class {
	#name : 'NGWonState',
	#superclass : 'NGGameState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'actions' }
NGWonState >> clearAtRow: aRow column: aColumn in: aGame [
]

{ #category : 'actions' }
NGWonState >> crossAtRow: aRow column: aColumn in: aGame [
]

{ #category : 'actions' }
NGWonState >> fillAtRow: aRow column: aColumn in: aGame [
]

{ #category : 'printing' }
NGWonState >> statusTextIn: aGame [
	^ 'Solved in ', aGame timer printElapsed
]
