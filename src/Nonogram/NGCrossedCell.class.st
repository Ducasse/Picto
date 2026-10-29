"
I am the state of a cell the player marked as probably empty.

## Responsibility:

- I become filled on a fill.
- I go back to unknown on a cross, and once the puzzle is won.
- I render as a cross.

## Collaborators:

- `NGCellState` is my abstract superclass.
- `NGCellElement` displays me.

## Public API and Key Messages

- `#afterFill`, `#afterCross`, `#afterWin`, `#renderOn:`

```
NGCrossedCell new afterCross >>> NGUnknownCell new
```

## Internal Representation

I have no instance variables.

### Implementation Points

- A cross is only a hypothesis of the player and is never judged against the solution.
"
Class {
	#name : 'NGCrossedCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGCrossedCell >> afterCross [
	^ NGUnknownCell new
]

{ #category : 'transitions' }
NGCrossedCell >> afterFill [
	^ NGFilledCell new
]

{ #category : 'transitions' }
NGCrossedCell >> afterWin [
	^ NGUnknownCell new
]

{ #category : 'printing' }
NGCrossedCell >> character [
	^ $x
]
