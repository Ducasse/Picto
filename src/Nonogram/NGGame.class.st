"
I am a play session on a puzzle.

Responsibility:
- apply the player's fill, cross and clear actions to a board
- refuse a fill on a cell that is empty in the stored solution, reveal that cell and take a life
- tell when the puzzle is solved (each line matches its clue) or lost (no life left)
- run a timer from the first action until the game is won or lost
- restart the game

Collaborators: NGPuzzle, NGBoard, NGTimer, and NGGameState subclasses to which actions are delegated.

Public API and Key Messages:
- NGGame class >> #on:, #on:lives: and #on:lives:timer: create me (3 lives by default)
- #toggleFillAtRow:column:, #toggleCrossAtRow:column:, #clearAtRow:column:, #restart
- #isSolved, #isRowSatisfiedAt:, #isColumnSatisfiedAt:, #livesLeft, #printLives, #statusText, #timer

	(NGGame on: NGPuzzles plus) toggleFillAtRow: 2 column: 2

Internal Representation and Key Implementation Points.

Instance Variables
	puzzle:		<NGPuzzle> the puzzle being played
	board:		<NGBoard> the player's grid
	timer:		<NGTimer> the time spent on the game
	lives:		<Integer> the number of lives at start
	livesLeft:	<Integer> the number of lives remaining
	state:		<NGGameState> playing, won or lost; won and lost ignore the actions

Crosses are never judged; only fills are checked against the stored solution.
"
Class {
	#name : 'NGGame',
	#superclass : 'Object',
	#instVars : [
		'puzzle',
		'board',
		'timer',
		'lives',
		'livesLeft',
		'state'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGGame class >> on: aPuzzle [
	^ self on: aPuzzle lives: 3
]

{ #category : 'instance creation' }
NGGame class >> on: aPuzzle lives: anInteger [
	^ self on: aPuzzle lives: anInteger timer: NGTimer new
]

{ #category : 'instance creation' }
NGGame class >> on: aPuzzle lives: anInteger timer: aTimer [
	^ self new setPuzzle: aPuzzle lives: anInteger timer: aTimer
]

{ #category : 'private' }
NGGame >> basicClearAtRow: aRow column: aColumn [
	self play: (board atRow: aRow column: aColumn) afterClear atRow: aRow column: aColumn
]

{ #category : 'private' }
NGGame >> basicCrossAtRow: aRow column: aColumn [
	self play: (board atRow: aRow column: aColumn) afterCross atRow: aRow column: aColumn
]

{ #category : 'private' }
NGGame >> basicFillAtRow: aRow column: aColumn [
	| newState |
	newState := (board atRow: aRow column: aColumn) afterFill.
	(newState isFilled and: [ (puzzle isFilledAtRow: aRow column: aColumn) not ])
		ifTrue: [ ^ self revealErrorAtRow: aRow column: aColumn ].
	self play: newState atRow: aRow column: aColumn
]

{ #category : 'accessing' }
NGGame >> board [
	^ board
]

{ #category : 'private' }
NGGame >> checkSolved [
	self isSolved ifFalse: [ ^ self ].
	timer stop.
	state := NGWonState new
]

{ #category : 'actions' }
NGGame >> clearAtRow: aRow column: aColumn [
	state clearAtRow: aRow column: aColumn in: self
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
NGGame >> lives [
	^ lives
]

{ #category : 'accessing' }
NGGame >> livesLeft [
	^ livesLeft
]

{ #category : 'private' }
NGGame >> lose [
	timer stop.
	state := NGLostState new
]

{ #category : 'private' }
NGGame >> play: aCellState atRow: aRow column: aColumn [
	(board atRow: aRow column: aColumn) = aCellState ifTrue: [ ^ self ].
	board atRow: aRow column: aColumn put: aCellState.
	timer start.
	self checkSolved
]

{ #category : 'printing' }
NGGame >> printLives [
	"One full heart per life left, one empty heart per life lost"
	^ (String new: livesLeft withAll: (Character value: 16r2665)) , (String new: lives - livesLeft withAll: (Character value: 16r2661))
]

{ #category : 'accessing' }
NGGame >> puzzle [
	^ puzzle
]

{ #category : 'actions' }
NGGame >> restart [
	board reset.
	livesLeft := lives.
	timer reset.
	state := NGPlayingState new
]

{ #category : 'private' }
NGGame >> revealErrorAtRow: aRow column: aColumn [
	"The player filled a cell that is empty in the solution: refuse the fill, reveal the cell and take a life"
	board atRow: aRow column: aColumn put: NGRevealedEmptyCell new.
	livesLeft := livesLeft - 1.
	timer start.
	livesLeft = 0 ifTrue: [ ^ self lose ].
	self checkSolved
]

{ #category : 'initialization' }
NGGame >> setPuzzle: aPuzzle lives: anInteger timer: aTimer [
	puzzle := aPuzzle.
	board := NGBoard for: aPuzzle.
	lives := anInteger.
	timer := aTimer.
	self restart
]

{ #category : 'accessing' }
NGGame >> statusText [
	^ state statusTextIn: self
]

{ #category : 'accessing' }
NGGame >> timer [
	^ timer
]

{ #category : 'actions' }
NGGame >> toggleCrossAtRow: aRow column: aColumn [
	state crossAtRow: aRow column: aColumn in: self
]

{ #category : 'actions' }
NGGame >> toggleFillAtRow: aRow column: aColumn [
	state fillAtRow: aRow column: aColumn in: self
]
