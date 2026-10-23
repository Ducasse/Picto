"
I am the state of a solved game: I ignore the player's actions.
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
