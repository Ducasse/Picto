"
I display a playable NGGame with Bloc elements and Toplo widgets.

Responsibility:
- show a toolbar with restart, the lives as hearts, a timer and a status
- show the grid with the clues and the cells, highlighting satisfied clues
- turn mouse clicks and keys into game actions

Mouse: a primary click fills a cell, a secondary click crosses it.
Keyboard: arrows move the cursor, Space or F fills, X crosses, Backspace or Delete clears.

Collaborators: NGGame, NGCellElement, NGClueElement, NGCursor.

Public API and Key Messages:
- NGGameElement class >> #on: creates me; #example opens one
- #fillAtRow:column:, #crossAtRow:column:, #clearAtRow:column:, #restart, #refresh

	NGGameElement example

Internal Representation and Key Implementation Points.

Instance Variables
	game:				<NGGame> the displayed game
	cells:				<Array of Arrays of NGCellElement> the cell elements by row
	rowClueElements:		<Array of NGClueElement> one per row
	columnClueElements:	<Array of NGClueElement> one per column
	cursor:				<NGCursor> the keyboard cursor
	statusLabel:			<ToLabel> shows the game status
	timerLabel:			<ToLabel> shows the elapsed time
	livesElement:			<BlElement> shows one heart icon per life, full or empty
	ticker:				<BlRepeatedTaskAction> refreshes the timer every second while I am in a space
"
Class {
	#name : 'NGGameElement',
	#superclass : 'ToElement',
	#instVars : [
		'game',
		'cells',
		'statusLabel',
		'rowClueElements',
		'columnClueElements',
		'cursor',
		'timerLabel',
		'ticker',
		'livesElement'
	],
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'examples' }
NGGameElement class >> example [
	<script>
	(self on: (NGGame on: (NGPuzzleLibrary default puzzleNamed: 'Heart'))) openInNewSpace
]

{ #category : 'instance creation' }
NGGameElement class >> on: aGame [
	^ self new setGame: aGame
]

{ #category : 'accessing' }
NGGameElement >> cellAtRow: aRow column: aColumn [
	^ (cells at: aRow) at: aColumn
]

{ #category : 'keyboard' }
NGGameElement >> clearAtCursor [
	self clearAtRow: cursor row column: cursor column
]

{ #category : 'actions' }
NGGameElement >> clearAtRow: aRow column: aColumn [
	cursor moveToRow: aRow column: aColumn.
	game clearAtRow: aRow column: aColumn.
	self refresh
]

{ #category : 'accessing' }
NGGameElement >> columnClueElementAt: anIndex [
	^ columnClueElements at: anIndex
]

{ #category : 'keyboard' }
NGGameElement >> crossAtCursor [
	self crossAtRow: cursor row column: cursor column
]

{ #category : 'actions' }
NGGameElement >> crossAtRow: aRow column: aColumn [
	cursor moveToRow: aRow column: aColumn.
	game toggleCrossAtRow: aRow column: aColumn.
	self refresh
]

{ #category : 'accessing' }
NGGameElement >> cursor [
	^ cursor
]

{ #category : 'keyboard' }
NGGameElement >> fillAtCursor [
	self fillAtRow: cursor row column: cursor column
]

{ #category : 'actions' }
NGGameElement >> fillAtRow: aRow column: aColumn [
	cursor moveToRow: aRow column: aColumn.
	game toggleFillAtRow: aRow column: aColumn.
	self refresh
]

{ #category : 'accessing' }
NGGameElement >> game [
	^ game
]

{ #category : 'keyboard' }
NGGameElement >> handleKey: aKey [
	self perform: (self keyActions at: aKey ifAbsent: [ ^ self ])
]

{ #category : 'initialization' }
NGGameElement >> installKeyboardHandlers [
	self addEventHandlerOn: BlKeyDownEvent do: [ :event | self handleKey: event key ]
]

{ #category : 'keyboard' }
NGGameElement >> keyActions [
	"Map each key to the action it triggers on the cell under the cursor"
	^ Dictionary newFrom: {
		KeyboardKey up -> #moveCursorUp.
		KeyboardKey down -> #moveCursorDown.
		KeyboardKey left -> #moveCursorLeft.
		KeyboardKey right -> #moveCursorRight.
		KeyboardKey space -> #fillAtCursor.
		KeyboardKey F -> #fillAtCursor.
		KeyboardKey X -> #crossAtCursor.
		KeyboardKey backspace -> #clearAtCursor.
		KeyboardKey delete -> #clearAtCursor }
]

{ #category : 'accessing' }
NGGameElement >> livesElement [
	^ livesElement
]

{ #category : 'keyboard' }
NGGameElement >> moveCursorDown [
	cursor moveDown.
	self refresh
]

{ #category : 'keyboard' }
NGGameElement >> moveCursorLeft [
	cursor moveLeft.
	self refresh
]

{ #category : 'keyboard' }
NGGameElement >> moveCursorRight [
	cursor moveRight.
	self refresh
]

{ #category : 'keyboard' }
NGGameElement >> moveCursorUp [
	cursor moveUp.
	self refresh
]

{ #category : 'building' }
NGGameElement >> newBoard [
	| puzzle board |
	puzzle := game puzzle.
	board := BlElement new
		layout: (BlGridLayout horizontal columnCount: puzzle width; cellSpacing: 0; yourself);
		background: NGPalette gridLine;
		padding: (BlInsets all: NGPalette border);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ];
		yourself.
	cells do: [ :rowCells |
		rowCells do: [ :cell |
			cell margin: (BlInsets
				top: 0
				right: (NGPalette gapAfter: cell column of: puzzle width)
				bottom: (NGPalette gapAfter: cell row of: puzzle height)
				left: 0).
			board addChild: cell ] ].
	^ board
]

{ #category : 'building' }
NGGameElement >> newCellElementAtRow: aRow column: aColumn [
	| cell |
	cell := NGCellElement row: aRow column: aColumn.
	cell addEventHandlerOn: BlPrimaryClickEvent do: [ :event |
		self requestFocus.
		self fillAtRow: aRow column: aColumn ].
	cell addEventHandlerOn: BlSecondaryClickEvent do: [ :event |
		self requestFocus.
		self crossAtRow: aRow column: aColumn ].
	^ cell
]

{ #category : 'building' }
NGGameElement >> newColumnClueStrip [
	| strip |
	strip := BlElement new
		layout: BlLinearLayout horizontal;
		padding: (BlInsets left: NGPalette border right: NGPalette border);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ];
		yourself.
	columnClueElements doWithIndex: [ :element :index |
		element margin: (BlInsets right: (NGPalette gapAfter: index of: columnClueElements size)).
		strip addChild: element ].
	^ strip
]

{ #category : 'building' }
NGGameElement >> newGrid [
	"A 2 x 2 grid: an empty corner, the column clues, the row clues and the board"
	| puzzle grid |
	puzzle := game puzzle.
	grid := BlElement new
		layout: (BlGridLayout horizontal columnCount: 2; cellSpacing: 0; yourself);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ];
		yourself.
	columnClueElements := puzzle columnClues collect: [ :clue | NGClueElement forColumn: clue ].
	rowClueElements := puzzle rowClues collect: [ :clue | NGClueElement forRow: clue ].
	cells := (1 to: puzzle height) collect: [ :row |
		(1 to: puzzle width) collect: [ :column | self newCellElementAtRow: row column: column ] ].
	grid addChild: (BlElement new extent: 0 @ 0).
	grid addChild: self newColumnClueStrip.
	grid addChild: self newRowClueStrip.
	grid addChild: self newBoard.
	^ grid
]

{ #category : 'building' }
NGGameElement >> newRowClueStrip [
	| strip |
	strip := BlElement new
		layout: BlLinearLayout vertical;
		padding: (BlInsets top: NGPalette border bottom: NGPalette border);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ];
		yourself.
	rowClueElements doWithIndex: [ :element :index |
		element margin: (BlInsets bottom: (NGPalette gapAfter: index of: rowClueElements size)).
		strip addChild: element ].
	^ strip
]

{ #category : 'building' }
NGGameElement >> newToolbar [
	| toolbar |
	toolbar := BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 16) alignCenterLeft;
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ];
		yourself.
	toolbar addChild: ((ToButton labelText: 'Restart') clickAction: [ self restart ]).
	livesElement := BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 2);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ];
		yourself.
	toolbar addChild: livesElement.
	timerLabel := ToLabel text: ''.
	toolbar addChild: timerLabel.
	statusLabel := ToLabel text: ''.
	toolbar addChild: statusLabel.
	^ toolbar
]

{ #category : 'rendering' }
NGGameElement >> refresh [
	cells do: [ :rowCells |
		rowCells do: [ :cell |
			(game board atRow: cell row column: cell column) renderOn: cell.
			cell hideCursor ] ].
	(self cellAtRow: cursor row column: cursor column) showCursor.
	rowClueElements withIndexDo: [ :element :index |
		(game isRowSatisfiedAt: index) ifTrue: [ element showSatisfied ] ifFalse: [ element showUnsatisfied ] ].
	columnClueElements withIndexDo: [ :element :index |
		(game isColumnSatisfiedAt: index) ifTrue: [ element showSatisfied ] ifFalse: [ element showUnsatisfied ] ].
	self refreshLives.
	self refreshTimer.
	statusLabel text: game statusText
]

{ #category : 'rendering' }
NGGameElement >> refreshLives [
	livesElement removeChildren.
	game livesLeft timesRepeat: [ livesElement addChild: NGIcons fullHeart ].
	game lives - game livesLeft timesRepeat: [ livesElement addChild: NGIcons emptyHeart ]
]

{ #category : 'rendering' }
NGGameElement >> refreshTimer [
	timerLabel text: game timer printElapsed
]

{ #category : 'actions' }
NGGameElement >> restart [
	game restart.
	self refresh
]

{ #category : 'accessing' }
NGGameElement >> rowClueElementAt: anIndex [
	^ rowClueElements at: anIndex
]

{ #category : 'initialization' }
NGGameElement >> setGame: aGame [
	game := aGame.
	cursor := NGCursor height: aGame puzzle height width: aGame puzzle width.
	ticker := BlRepeatedTaskAction new.
	self
		layout: (BlLinearLayout vertical cellSpacing: 12);
		padding: (BlInsets all: 16);
		background: NGPalette background;
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ].
	self addChild: self newToolbar.
	self addChild: self newGrid.
	self installKeyboardHandlers.
	self addEventHandlerOn: BlElementAddedToSceneGraphEvent do: [ :event |
		self startTicking.
		self requestFocus ].
	self addEventHandlerOn: BlElementRemovedFromSceneGraphEvent do: [ :event | self stopTicking ].
	self refresh
]

{ #category : 'timer' }
NGGameElement >> startTicking [
	ticker := BlRepeatedTaskAction new
		delay: 1 second;
		action: [ self refreshTimer ];
		yourself.
	self enqueueTask: ticker
]

{ #category : 'accessing' }
NGGameElement >> statusText [
	^ statusLabel text asString
]

{ #category : 'timer' }
NGGameElement >> stopTicking [
	ticker stop
]

{ #category : 'accessing' }
NGGameElement >> timerText [
	^ timerLabel text asString
]
