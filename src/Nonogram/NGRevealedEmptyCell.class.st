"
I am the state of a cell the player wrongly tried to fill: the fill was refused and I reveal that the cell is empty.

## Responsibility:

- I stay unchanged whatever the action of the player: I am locked.
- I become unknown once the puzzle is won, so only filled cells remain visible.
- I render as a reddish cell.

## Collaborators:

- `NGGame` puts me on the board on an error.
- `NGCellElement` displays me.

## Public API and Key Messages

- `#afterFill`, `#afterCross`, `#afterClear` all answer myself.
- `#afterWin` answers an unknown cell.
- `#renderOn:`

```
NGRevealedEmptyCell new afterClear >>> NGRevealedEmptyCell new
```

## Internal Representation

I have no instance variables.
"
Class {
	#name : 'NGRevealedEmptyCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterClear [
	^ self
]

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterCross [
	^ self
]

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterFill [
	^ self
]

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterWin [
	^ NGUnknownCell new
]

{ #category : 'printing' }
NGRevealedEmptyCell >> character [
	^ $!
]

{ #category : 'rendering' }
NGRevealedEmptyCell >> renderOn: aCellElement [
	aCellElement showRevealedEmpty
]
