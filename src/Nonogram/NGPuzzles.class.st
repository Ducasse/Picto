"
I am the catalog of built-in puzzles.

Responsibility: define each built-in puzzle in a class-side method tagged with the <puzzle> pragma.

Collaborators: NGPuzzleLibrary class >> #default collects my <puzzle> methods.

Public API and Key Messages: class-side #heart, #house, #plus

	NGPuzzles heart

Internal Representation and Key Implementation Points.

I have no state. To add a puzzle, add a class-side method with the <puzzle> pragma answering an NGPuzzle; NGPuzzlesTest checks it has a single solution.
"
Class {
	#name : 'NGPuzzles',
	#superclass : 'Object',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'puzzles' }
NGPuzzles class >> heart [
	<puzzle>
	^ NGPuzzle named: 'Heart' fromStrings: #('.##.##.' '#######' '#######' '.#####.' '..###..' '...#...')
]

{ #category : 'puzzles' }
NGPuzzles class >> house [
	<puzzle>
	^ NGPuzzle named: 'House' fromStrings: #('...#...' '..###..' '.#####.' '#######' '.#...#.' '.#.#.#.' '.#.#.#.' '.#####.')
]

{ #category : 'puzzles' }
NGPuzzles class >> plus [
	<puzzle>
	^ NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')
]
