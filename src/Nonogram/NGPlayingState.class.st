"
I am the state of a game in progress: I forward the player's actions to the game.
"
Class {
	#name : 'NGPlayingState',
	#superclass : 'NGGameState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'actions' }
NGPlayingState >> clearAtRow: aRow column: aColumn in: aGame [
	aGame basicClearAtRow: aRow column: aColumn
]

{ #category : 'actions' }
NGPlayingState >> crossAtRow: aRow column: aColumn in: aGame [
	aGame basicCrossAtRow: aRow column: aColumn
]

{ #category : 'actions' }
NGPlayingState >> fillAtRow: aRow column: aColumn in: aGame [
	aGame basicFillAtRow: aRow column: aColumn
]

{ #category : 'printing' }
NGPlayingState >> statusTextIn: aGame [
	^ ''
]
