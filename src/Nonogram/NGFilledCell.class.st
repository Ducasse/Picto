"
I am the state of a cell the player has filled.

## Responsibility:

- I count as filled.
- I go back to unknown on a fill and become crossed on a cross.
- I render as a black cell.

## Collaborators:

- `NGCellState` is my abstract superclass.
- `NGCellElement` displays me.

## Public API and Key Messages

- `#isFilled`, `#afterFill`, `#afterCross`, `#renderOn:`

```
NGFilledCell new isFilled >>> true
```

## Internal Representation

I have no instance variables.
"
Class {
	#name : 'NGFilledCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGFilledCell >> afterCross [
	^ NGCrossedCell new
]

{ #category : 'transitions' }
NGFilledCell >> afterFill [
	^ NGUnknownCell new
]

{ #category : 'printing' }
NGFilledCell >> character [
	^ $#
]

{ #category : 'testing' }
NGFilledCell >> isFilled [
	^ true
]
