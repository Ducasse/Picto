"
I am signalled when a puzzle with more than one solution is added to an NGPuzzleLibrary.

Responsibility: carry the ambiguous puzzle and another solution, and describe them in my message.

Collaborators: NGPuzzleLibrary signals me.

Public API and Key Messages:
- NGAmbiguousPuzzleError class >> #signalFor:otherSolution:
- #puzzle, #otherSolution, #messageText

	[ NGPuzzleLibrary new add: aPuzzle ] on: NGAmbiguousPuzzleError do: [ :error | error otherSolution ]

Internal Representation and Key Implementation Points.

Instance Variables
	puzzle:			<NGPuzzle> the rejected puzzle
	otherSolution:	<Array of Arrays of Booleans> a solution different from the stored one
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
