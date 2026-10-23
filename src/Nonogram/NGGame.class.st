"
I am a play session on a puzzle. I apply the player's actions (fill, cross, clear) to a board, keep a history for undo, and tell when the puzzle is solved.

A board is solved when each of its lines matches the puzzle clues, so any valid solution is accepted, not only the stored one.

I own an NGTimer that starts with the first move, stops when the puzzle gets solved and is reset on restart.
"
Class {
	#name : 'NGGame',
	#superclass : 'Object',
	#instVars : [
		'puzzle',
		'board',
		'history',
		'timer'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGGame class >> on: aPuzzle [
	^ self on: aPuzzle timer: NGTimer new
]

{ #category : 'instance creation' }
NGGame class >> on: aPuzzle timer: aTimer [
	^ self new setPuzzle: aPuzzle timer: aTimer
]

{ #category : 'accessing' }
NGGame >> board [
	^ board
]

{ #category : 'testing' }
NGGame >> canUndo [
	^ history notEmpty
]

{ #category : 'actions' }
NGGame >> clearAtRow: aRow column: aColumn [
	self play: NGUnknownCell new atRow: aRow column: aColumn
]

{ #category : 'testing' }
NGGame >> isColumnSatisfiedAt: anIndex [

	^ puzzle isColumnSatisfiedAt: anIndex by: board
]

{ #category : 'testing' }
NGGame >> isRowSatisfiedAt: anIndex [

	^ puzzle isRowSatisfiedAt: anIndex by: board
]

{ #category : 'testing' }
NGGame >> isSolved [
	^ puzzle isSolvedBy: board
]

{ #category : 'accessing' }
NGGame >> moveCount [
	^ history size
]

{ #category : 'actions' }
NGGame >> play: aCellState atRow: aRow column: aColumn [
	| move previous |
	previous := board atRow: aRow column: aColumn.
	previous = aCellState ifTrue: [ ^ self ].
	move := NGMove row: aRow column: aColumn from: previous to: aCellState.
	move applyTo: board.
	history addLast: move.
	timer start.
	self isSolved ifTrue: [ timer stop ]
]

{ #category : 'accessing' }
NGGame >> puzzle [
	^ puzzle
]

{ #category : 'actions' }
NGGame >> restart [
	board reset.
	history removeAll.
	timer reset
]

{ #category : 'initialization' }
NGGame >> setPuzzle: aPuzzle timer: aTimer [
	puzzle := aPuzzle.
	board := NGBoard for: aPuzzle.
	history := OrderedCollection new.
	timer := aTimer
]

{ #category : 'accessing' }
NGGame >> timer [
	^ timer
]

{ #category : 'actions' }
NGGame >> toggleCrossAtRow: aRow column: aColumn [
	self play: (board atRow: aRow column: aColumn) afterCross atRow: aRow column: aColumn
]

{ #category : 'actions' }
NGGame >> toggleFillAtRow: aRow column: aColumn [
	self play: (board atRow: aRow column: aColumn) afterFill atRow: aRow column: aColumn
]

{ #category : 'actions' }
NGGame >> undo [
	history ifEmpty: [ ^ self ].
	history removeLast undoOn: board
]
