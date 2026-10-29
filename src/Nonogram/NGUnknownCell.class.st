"
I am the state of a cell the player has not decided on yet. Every cell of a new board starts with me.

## Responsibility:

- I become filled on a fill.
- I become crossed on a cross.
- I render as a blank cell.

## Collaborators:

- `NGCellState` is my abstract superclass.
- `NGCellElement` displays me.

## Public API and Key Messages

- `#afterFill`, `#afterCross`, `#renderOn:`

```
NGUnknownCell new afterCross >>> NGCrossedCell new
```

## Internal Representation

I have no instance variables.
"
Class {
	#name : 'NGUnknownCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGUnknownCell >> afterCross [
	^ NGCrossedCell new
]

{ #category : 'transitions' }
NGUnknownCell >> afterFill [
	^ NGFilledCell new
]

{ #category : 'printing' }
NGUnknownCell >> character [
	^ $.
]
