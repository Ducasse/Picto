"
I test NGAmbiguousPuzzleError.
"
Class {
	#name : 'NGAmbiguousPuzzleErrorTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGAmbiguousPuzzleErrorTest >> testMessageShowsOtherSolution [
	| puzzle error |
	puzzle := NGPuzzle named: 'Diagonal' fromStrings: #('#.' '.#').
	error := [ NGAmbiguousPuzzleError signalFor: puzzle otherSolution: #(#(false true) #(true false)) ]
		on: NGAmbiguousPuzzleError
		do: [ :e | e ].
	self assert: error puzzle equals: puzzle.
	self assert: error messageText equals: 'Puzzle Diagonal has more than one solution, for example:', (String with: Character cr), '.#', (String with: Character cr), '#.'
]
