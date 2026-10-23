"
I am a play session on a puzzle. I apply the player's actions (fill, cross, clear) to a board through my state (playing, won or lost) and tell when the puzzle is solved.

Filling a cell that is empty in the stored solution is an error: the fill is refused, the cell is revealed as empty and locked, and the player loses one of my lives. Crosses are only the player's hypotheses and are never judged. When no life is left the game is lost.

The puzzle is solved when each line of the board matches its clue.

I own an NGTimer that starts with the first action, stops when the game is won or lost, and is reset on restart.
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
