"
I am a play session on a puzzle. I apply the player's actions (fill, cross, clear) to a board, keep a history for undo, and tell when the puzzle is solved.

A board is solved when each of its lines matches the puzzle clues, so any valid solution is accepted, not only the stored one.
"
Class {
	#name : 'NGSGame',
	#superclass : 'Object',
	#instVars : [
		'puzzle',
		'board',
		'history'
	],
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGSGame class >> on: aPuzzle [
	^ self new setPuzzle: aPuzzle
]

{ #category : 'accessing' }
NGSGame >> board [
	^ board
]

{ #category : 'testing' }
NGSGame >> canUndo [
	^ history notEmpty
]

{ #category : 'actions' }
NGSGame >> clearAtRow: aRow column: aColumn [
	self play: NGSUnknownCell new atRow: aRow column: aColumn
]

{ #category : 'testing' }
NGSGame >> isSolved [
	^ puzzle isSolvedBy: board
]

{ #category : 'accessing' }
NGSGame >> moveCount [
	^ history size
]

{ #category : 'private' }
NGSGame >> play: aCellState atRow: aRow column: aColumn [
	| move previous |
	previous := board atRow: aRow column: aColumn.
	previous = aCellState ifTrue: [ ^ self ].
	move := NGSMove row: aRow column: aColumn from: previous to: aCellState.
	move applyTo: board.
	history addLast: move
]

{ #category : 'accessing' }
NGSGame >> puzzle [
	^ puzzle
]

{ #category : 'actions' }
NGSGame >> restart [
	board reset.
	history removeAll
]

{ #category : 'initialization' }
NGSGame >> setPuzzle: aPuzzle [
	puzzle := aPuzzle.
	board := NGSBoard for: aPuzzle.
	history := OrderedCollection new
]

{ #category : 'actions' }
NGSGame >> toggleCrossAtRow: aRow column: aColumn [
	self play: (board atRow: aRow column: aColumn) afterCross atRow: aRow column: aColumn
]

{ #category : 'actions' }
NGSGame >> toggleFillAtRow: aRow column: aColumn [
	self play: (board atRow: aRow column: aColumn) afterFill atRow: aRow column: aColumn
]

{ #category : 'actions' }
NGSGame >> undo [
	history ifEmpty: [ ^ self ].
	history removeLast undoOn: board
]
