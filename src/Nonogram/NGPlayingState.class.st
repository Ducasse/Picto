"
I am the state of a game in progress.

## Responsibility:

- I forward the player's actions to the game.
- I answer an empty status.
- I hide any outcome shown on the game element.

## Collaborators:

- `NGGame` delegates to me and receives the forwarded actions.
- `NGGameState` is my abstract superclass.

## Public API and Key Messages

- `#fillAtRow:column:in:`, `#crossAtRow:column:in:`, `#clearAtRow:column:in:`
- `#statusTextIn:`

```
NGPlayingState new fillAtRow: 1 column: 1 in: aGame
```

## Internal Representation

I have no instance variables.
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

{ #category : 'rendering' }
NGPlayingState >> showOutcomeOn: aGameElement for: aGame [
	aGameElement hideOutcome
]

{ #category : 'printing' }
NGPlayingState >> statusTextIn: aGame [
	^ ''
]
