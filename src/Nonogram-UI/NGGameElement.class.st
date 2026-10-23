"
I display a playable NGGame with Bloc elements and Toplo widgets: a toolbar with restart, the lives as hearts, a timer and a status, and a grid with the clues and the cells. Clues of satisfied lines are shown greyed on a pale green background; wrongly filled cells show a red cross.

Mouse: a primary click fills a cell, a secondary click crosses it.
Keyboard: arrows move the cursor, Space or F fills, X crosses, Backspace or Delete clears.

	NGGameElement example
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
		'livesLabel'
	],
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'examples' }
NGGameElement class >> example [
	<script>
	(self on: (NGGame on: (NGPuzzle
		named: 'Heart'
		fromStrings: #('.##.##.' '#######' '#######' '.#####.' '..###..' '...#...')))) openInNewSpace
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
NGGameElement >> livesText [
	^ livesLabel text asString
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
NGGameElement >> newGrid [

	| puzzle grid |
	puzzle := game puzzle.
	grid := BlElement new
		        layout: (BlGridLayout horizontal
				         columnCount: puzzle width + 1;
				         cellSpacing: 2;
				         yourself);
		        constraintsDo: [ :layoutConstraints |
				        layoutConstraints horizontal fitContent.
				        layoutConstraints vertical fitContent ];
		        yourself.
	grid addChild: (BlElement new extent: 0 @ 0).
	columnClueElements := puzzle columnClues collect: [ :clue | NGClueElement forColumn: clue ].
	grid addChildren: columnClueElements.
	rowClueElements := (1 to: puzzle height) collect: [ :row | NGClueElement forRow: (puzzle rowClueAt: row) ].
	cells := (1 to: puzzle height) collect: [ :row |
			         | rowCells |
			         rowCells := (1 to: puzzle width) collect: [ :column | self newCellElementAtRow: row column: column ].
			         grid addChild: (rowClueElements at: row).
			         grid addChildren: rowCells.
			         rowCells ].
	^ grid
]

{ #category : 'building' }
NGGameElement >> newToolbar [
	| toolbar |
	toolbar := BlElement new
		layout: (BlLinearLayout horizontal cellSpacing: 8);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ];
		yourself.
	toolbar addChild: ((ToButton labelText: 'Restart') clickAction: [ self restart ]).
	livesLabel := ToLabel text: ''.
	toolbar addChild: livesLabel.
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
	livesLabel text: (game printLives asRopedText
		foreground: Color red;
		fontSize: NGCellElement fontSize;
		yourself).
	self refreshTimer.
	statusLabel text: game statusText
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
