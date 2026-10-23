"
I display a playable NGGame with Bloc elements and Toplo widgets: a toolbar with undo and restart, and a grid with the clues and the cells. A primary click fills a cell, a secondary click crosses it.

	NGGameElement example
"
Class {
	#name : 'NGGameElement',
	#superclass : 'ToElement',
	#instVars : [
		'game',
		'cells',
		'statusLabel'
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

{ #category : 'actions' }
NGGameElement >> crossAtRow: aRow column: aColumn [
	game toggleCrossAtRow: aRow column: aColumn.
	self refresh
]

{ #category : 'actions' }
NGGameElement >> fillAtRow: aRow column: aColumn [
	game toggleFillAtRow: aRow column: aColumn.
	self refresh
]

{ #category : 'accessing' }
NGGameElement >> game [
	^ game
]

{ #category : 'building' }
NGGameElement >> newCellElementAtRow: aRow column: aColumn [
	| cell |
	cell := NGCellElement row: aRow column: aColumn.
	cell addEventHandlerOn: BlPrimaryClickEvent do: [ :event | self fillAtRow: aRow column: aColumn ].
	cell addEventHandlerOn: BlSecondaryClickEvent do: [ :event | self crossAtRow: aRow column: aColumn ].
	^ cell
]

{ #category : 'building' }
NGGameElement >> newColumnClueElement: aClue [
	| element |
	element := BlElement new
		layout: BlLinearLayout vertical alignBottomCenter;
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal exact: NGCellElement cellSize.
			layoutConstraints vertical fitContent ];
		yourself.
	(aClue isEmpty ifTrue: [ #(0) ] ifFalse: [ aClue blocks ])
		do: [ :each | element addChild: (ToLabel text: each printString) ].
	^ element
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
	puzzle columnClues do: [ :clue | grid addChild: (self newColumnClueElement: clue) ].
	cells := (1 to: puzzle height) collect: [ :row |
			         grid addChild: (self newRowClueElement: (puzzle rowClueAt: row)).
			         (1 to: puzzle width) collect: [ :column |
					         | cell |
					         cell := self newCellElementAtRow: row column: column.
					         grid addChild: cell.
					         cell ] ].
	^ grid
]

{ #category : 'building' }
NGGameElement >> newRowClueElement: aClue [
	| element |
	element := BlElement new
		layout: BlLinearLayout horizontal alignCenterRight;
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical exact: NGCellElement cellSize ];
		yourself.
	element addChild: (ToLabel text: aClue printString).
	^ element
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
	toolbar addChild: ((ToButton labelText: 'Undo') clickAction: [ self undo ]).
	toolbar addChild: ((ToButton labelText: 'Restart') clickAction: [ self restart ]).
	statusLabel := ToLabel text: ''.
	toolbar addChild: statusLabel.
	^ toolbar
]

{ #category : 'rendering' }
NGGameElement >> refresh [
	cells do: [ :rowCells |
		rowCells do: [ :cell | (game board atRow: cell row column: cell column) renderOn: cell ] ].
	statusLabel text: (game isSolved ifTrue: [ 'Solved!' ] ifFalse: [ '' ])
]

{ #category : 'actions' }
NGGameElement >> restart [
	game restart.
	self refresh
]

{ #category : 'initialization' }
NGGameElement >> setGame: aGame [
	game := aGame.
	self
		layout: (BlLinearLayout vertical cellSpacing: 12);
		padding: (BlInsets all: 16);
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical fitContent ].
	self addChild: self newToolbar.
	self addChild: self newGrid.
	self refresh
]

{ #category : 'accessing' }
NGGameElement >> statusText [
	^ statusLabel text asString
]

{ #category : 'actions' }
NGGameElement >> undo [
	game undo.
	self refresh
]
