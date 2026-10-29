"
I am signalled when a puzzle with more than one solution is added to an `NGPuzzleLibrary`: I protect the library from puzzles that the player could not solve by logic alone.

## Responsibility:

- I carry the rejected ambiguous puzzle.
- I carry another solution, different from the stored one, that proves the ambiguity.
- I describe both in my message text so the puzzle author can fix the picture.

## Collaborators:

- `NGPuzzleLibrary` signals me when it refuses a puzzle.
- `NGPuzzle` is the rejected puzzle I hold.

## Public API and Key Messages

- `NGAmbiguousPuzzleError class >> #signalFor:otherSolution:` creates and signals me.
- `#puzzle` and `#otherSolution` answer what I carry.
- `#messageText` shows the other solution.

```
[ NGPuzzleLibrary new add: aPuzzle ]
	on: NGAmbiguousPuzzleError
	do: [ :error | error otherSolution ]
```

## Internal Representation

- `puzzle`: <`NGPuzzle`> the rejected puzzle.
- `otherSolution`: <Array of Arrays of Booleans> a solution different from the stored one.
"
Class {
	#name : 'NGAmbiguousPuzzleError',
	#superclass : 'Error',
	#instVars : [
		'puzzle',
		'otherSolution'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'signalling' }
NGAmbiguousPuzzleError class >> signalFor: aPuzzle otherSolution: aSolution [
	^ self new setPuzzle: aPuzzle otherSolution: aSolution; signal
]

{ #category : 'accessing' }
NGAmbiguousPuzzleError >> messageText [
	^ String streamContents: [ :stream |
		stream nextPutAll: 'Puzzle ', puzzle name, ' has more than one solution, for example:'.
		otherSolution do: [ :row |
			stream cr.
			row do: [ :filled | stream nextPut: (filled ifTrue: [ $# ] ifFalse: [ $. ]) ] ] ]
]

{ #category : 'accessing' }
NGAmbiguousPuzzleError >> otherSolution [
	^ otherSolution
]

{ #category : 'accessing' }
NGAmbiguousPuzzleError >> puzzle [
	^ puzzle
]

{ #category : 'initialization' }
NGAmbiguousPuzzleError >> setPuzzle: aPuzzle otherSolution: aSolution [
	puzzle := aPuzzle.
	otherSolution := aSolution
]
