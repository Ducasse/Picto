"
I am the state of a solved game.

## Responsibility:

- I ignore the player's actions.
- I answer a status with the solving time.
- I show the winning banner.

## Collaborators:

- `NGGame` delegates to me.
- `NGTimer` gives the solving time.
- `NGGameState` is my abstract superclass.

## Public API and Key Messages

- `#statusTextIn:` answers `'Solved in mm:ss'`.

```
NGWonState new statusTextIn: aGame
```

## Internal Representation

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

{ #category : 'rendering' }
NGWonState >> showOutcomeOn: aGameElement for: aGame [
	aGameElement showWon: (self statusTextIn: aGame) , '!'
]

{ #category : 'printing' }
NGWonState >> statusTextIn: aGame [
	^ 'Solved in ', aGame timer printElapsed
]
