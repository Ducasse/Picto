"
I am the state of a game where the player lost all lives.

## Responsibility:

- I ignore the player's actions.
- I answer `'Game over'` as status.
- I show the game over overlay.

## Collaborators:

- `NGGame` delegates to me.
- `NGGameState` is my abstract superclass.

## Public API and Key Messages

- `#statusTextIn:`

```
NGLostState new statusTextIn: aGame >>> 'Game over'
```

## Internal Representation

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
