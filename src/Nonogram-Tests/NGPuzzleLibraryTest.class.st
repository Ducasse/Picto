"
I test NGPuzzleLibrary.
"
Class {
	#name : 'NGPuzzleLibraryTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGPuzzleLibraryTest >> testAddUniquePuzzle [
	| library |
	library := NGPuzzleLibrary new.
	library add: NGPuzzles plus.
	self assert: library size equals: 1.
	self assert: (library puzzleNamed: 'Plus') name equals: 'Plus'
]

{ #category : 'tests' }
NGPuzzleLibraryTest >> testAmbiguousPuzzleIsRejected [
	| library error |
	library := NGPuzzleLibrary new.
	error := [ library add: (NGPuzzle named: 'Diagonal' fromStrings: #('#.' '.#')) ]
		on: NGAmbiguousPuzzleError
		do: [ :e | e ].
	self assert: error otherSolution equals: #(#(false true) #(true false)).
	self assert: library size equals: 0
]

{ #category : 'tests' }
NGPuzzleLibraryTest >> testDefault [
	| names |
	names := NGPuzzleLibrary default puzzles collect: [ :each | each name ].
	self assert: names size equals: 11.
	self assert: (names includesAll: #('Heart' 'Lighthouse' 'Great balloon' 'Cat'))
]

{ #category : 'tests' }
NGPuzzleLibraryTest >> testSameNameReplacesInPlace [
	| library other |
	library := NGPuzzleLibrary new.
	library add: NGPuzzles plus; add: NGPuzzles heart.
	other := NGPuzzle named: 'Plus' fromStrings: #('#').
	library add: other.
	self assert: library size equals: 2.
	self assert: library puzzles first equals: other
]
