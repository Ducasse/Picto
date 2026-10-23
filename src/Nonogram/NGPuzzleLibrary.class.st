"
I am a collection of playable puzzles: each one has a single solution.

Responsibility:
- accept a puzzle only if it has a single solution, otherwise signal NGAmbiguousPuzzleError
- give access to my puzzles in insertion order and by name

Collaborators: NGPuzzle, NGSolver, NGAmbiguousPuzzleError, NGPuzzles for the default content.

Public API and Key Messages:
- NGPuzzleLibrary class >> #default answers a new library with every built-in puzzle
- #add:, #puzzles, #puzzleNamed:, #size

	NGPuzzleLibrary default puzzleNamed: 'Heart'

Internal Representation and Key Implementation Points.

Instance Variables
	puzzles:	<OrderedDictionary> puzzles by name; adding a name twice replaces the earlier puzzle in place

The default library is rebuilt on each access, so I keep no global state.
"
Class {
	#name : 'NGPuzzleLibrary',
	#superclass : 'Object',
	#instVars : [
		'puzzles'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGPuzzleLibrary class >> default [
	"Answer a new library holding every puzzle defined by a <puzzle> method of NGPuzzles"
	| library |
	library := self new.
	((Pragma allNamed: #puzzle in: NGPuzzles class) sorted: [ :a :b | a methodSelector <= b methodSelector ])
		do: [ :pragma | library add: (NGPuzzles perform: pragma methodSelector) ].
	^ library
]

{ #category : 'adding' }
NGPuzzleLibrary >> add: aPuzzle [
	"Add aPuzzle if it has a single solution; a puzzle with the same name is replaced in place"
	| solutions |
	solutions := (NGSolver forPuzzle: aPuzzle) solutionsUpTo: 2.
	solutions size = 1 ifFalse: [
		^ NGAmbiguousPuzzleError
			signalFor: aPuzzle
			otherSolution: (solutions detect: [ :each | each ~= aPuzzle solution ]) ].
	^ puzzles at: aPuzzle name put: aPuzzle
]

{ #category : 'initialization' }
NGPuzzleLibrary >> initialize [
	super initialize.
	puzzles := OrderedDictionary new
]

{ #category : 'accessing' }
NGPuzzleLibrary >> puzzleNamed: aString [
	^ puzzles at: aString
]

{ #category : 'accessing' }
NGPuzzleLibrary >> puzzles [
	^ puzzles values
]

{ #category : 'accessing' }
NGPuzzleLibrary >> size [
	^ puzzles size
]
