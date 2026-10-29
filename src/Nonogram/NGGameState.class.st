"
I am the abstract state of an `NGGame`.

## Responsibility:

- I handle the player's fill, cross and clear actions.
- I describe the status of the game.
- I show the end of the game, if any, on a game element.

## Collaborators:

- `NGGame` delegates its actions to me.
- My subclasses `NGPlayingState`, `NGWonState` and `NGLostState` define the concrete behavior.
- `NGGameElement` is where I show the outcome.

## Public API and Key Messages

- `#fillAtRow:column:in:`, `#crossAtRow:column:in:`, `#clearAtRow:column:in:`
- `#statusTextIn:`
- `#showOutcomeOn:for:` shows the end of the game on an `NGGameElement`.

```
NGPlayingState new statusTextIn: aGame
```

## Internal Representation

I have no instance variables.

### Implementation Points

- A finished game ignores actions by polymorphism rather than by testing flags.
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

{ #category : 'rendering' }
NGGameState >> showOutcomeOn: aGameElement for: aGame [
	"Show on aGameElement how the game ended, if it did"
	^ self subclassResponsibility
]

{ #category : 'printing' }
NGGameState >> statusTextIn: aGame [
	^ self subclassResponsibility
]
