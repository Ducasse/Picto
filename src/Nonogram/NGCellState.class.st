"
I am the abstract state of a cell on a player's board.

## Responsibility:

- I answer the state reached after a fill, cross or clear action, and once the puzzle is won.
- I tell whether I count as filled.
- I render myself on a cell element.

## Collaborators:

- My subclasses `NGUnknownCell`, `NGFilledCell`, `NGCrossedCell` and `NGRevealedEmptyCell` define the concrete behavior.
- `NGBoard` stores me.
- `NGCellElement` displays me when I call it through `#renderOn:`.

## Public API and Key Messages

- `#afterFill`, `#afterCross`, `#afterClear` answer the next state; `#afterClear` answers an unknown cell.
- `#afterWin` answers the state shown once the puzzle is solved: only filled cells remain visible.
- `#isFilled` tells whether I count as filled.
- `#renderOn:` asks a cell element to show me; `#character` answers my textual form.

```
NGUnknownCell new afterFill >>> NGFilledCell new
```

## Internal Representation

I have no instance variables.

### Implementation Points

- States are compared by class, so behavior is chosen by polymorphism rather than by testing.
"
Class {
	#name : 'NGCellState',
	#superclass : 'Object',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'comparing' }
NGCellState >> = anObject [
	^ self class = anObject class
]

{ #category : 'transitions' }
NGCellState >> afterClear [
	"Return the state reached when the player clears me"
	^ NGUnknownCell new
]

{ #category : 'transitions' }
NGCellState >> afterCross [
	"Return the state reached when the player uses the cross action on me"
	^ self subclassResponsibility
]

{ #category : 'transitions' }
NGCellState >> afterFill [
	"Return the state reached when the player uses the fill action on me"
	^ self subclassResponsibility
]

{ #category : 'transitions' }
NGCellState >> afterWin [
	"Return the state shown once the puzzle is solved: only filled cells remain visible"
	^ self
]

{ #category : 'printing' }
NGCellState >> character [
	^ self subclassResponsibility
]

{ #category : 'comparing' }
NGCellState >> hash [
	^ self class hash
]

{ #category : 'testing' }
NGCellState >> isFilled [
	^ false
]

{ #category : 'printing' }
NGCellState >> printOn: aStream [
	super printOn: aStream. 
	aStream nextPutAll: ' ('.
	aStream nextPut: self character.
	aStream nextPutAll: ')'.
]
