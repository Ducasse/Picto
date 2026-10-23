"
I am a play session on a puzzle. I apply the player's actions (fill, cross, clear) to a board, keep a history for undo, and tell when the puzzle is solved.

A board is solved when each of its lines matches the puzzle clues, so any valid solution is accepted, not only the stored one.
"
Class {
	#name : 'NGGame',
	#superclass : 'Object',
	#instVars : [
		'puzzle',
		'board',
		'history'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGGame class >> on: aPuzzle [
	^ self new setPuzzle: aPuzzle
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
NGGame >> isSolved [
	^ puzzle isSolvedBy: board
]

{ #category : 'accessing' }
NGGame >> moveCount [
	^ history size
]

{ #category : 'private' }
NGGame >> play: aCellState atRow: aRow column: aColumn [
	| move previous |
	previous := board atRow: aRow column: aColumn.
	previous = aCellState ifTrue: [ ^ self ].
	move := NGMove row: aRow column: aColumn from: previous to: aCellState.
	move applyTo: board.
	history addLast: move
]

{ #category : 'accessing' }
NGGame >> puzzle [
	^ puzzle
]

{ #category : 'actions' }
NGGame >> restart [
	board reset.
	history removeAll
]

{ #category : 'initialization' }
NGGame >> setPuzzle: aPuzzle [
	puzzle := aPuzzle.
	board := NGBoard for: aPuzzle.
	history := OrderedCollection new
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
