"
I display a playable NGSGame with Bloc elements and Toplo widgets: a toolbar with undo and restart, and a grid with the clues and the cells. A primary click fills a cell, a secondary click crosses it.

	NGSGameElement example
"
Class {
	#name : 'NGSGameElement',
	#superclass : 'ToElement',
	#instVars : [
		'game',
		'cells',
		'statusLabel'
	],
	#category : 'SimpleNonogram-UI-Core',
	#package : 'SimpleNonogram-UI',
	#tag : 'Core'
}

{ #category : 'examples' }
NGSGameElement class >> example [
	<script>
	(self on: (NGSGame on: (NGSPuzzle
		named: 'Heart'
		fromStrings: #('.##.##.' '#######' '#######' '.#####.' '..###..' '...#...')))) openInNewSpace
]

{ #category : 'instance creation' }
NGSGameElement class >> on: aGame [
	^ self new setGame: aGame
]

{ #category : 'accessing' }
NGSGameElement >> cellAtRow: aRow column: aColumn [
	^ (cells at: aRow) at: aColumn
]

{ #category : 'actions' }
NGSGameElement >> crossAtRow: aRow column: aColumn [
	game toggleCrossAtRow: aRow column: aColumn.
	self refresh
]

{ #category : 'actions' }
NGSGameElement >> fillAtRow: aRow column: aColumn [
	game toggleFillAtRow: aRow column: aColumn.
	self refresh
]

{ #category : 'accessing' }
NGSGameElement >> game [
	^ game
]

{ #category : 'building' }
NGSGameElement >> newCellElementAtRow: aRow column: aColumn [
	| cell |
	cell := NGSCellElement row: aRow column: aColumn.
	cell addEventHandlerOn: BlPrimaryClickEvent do: [ :event | self fillAtRow: aRow column: aColumn ].
	cell addEventHandlerOn: BlSecondaryClickEvent do: [ :event | self crossAtRow: aRow column: aColumn ].
	^ cell
]

{ #category : 'building' }
NGSGameElement >> newColumnClueElement: aClue [
	| element |
	element := BlElement new
		layout: BlLinearLayout vertical alignBottomCenter;
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal exact: NGSCellElement cellSize.
			layoutConstraints vertical fitContent ];
		yourself.
	(aClue isEmpty ifTrue: [ #(0) ] ifFalse: [ aClue blocks ])
		do: [ :each | element addChild: (ToLabel text: each printString) ].
	^ element
]

{ #category : 'building' }
NGSGameElement >> newGrid [

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
NGSGameElement >> newRowClueElement: aClue [
	| element |
	element := BlElement new
		layout: BlLinearLayout horizontal alignCenterRight;
		constraintsDo: [ :layoutConstraints |
			layoutConstraints horizontal fitContent.
			layoutConstraints vertical exact: NGSCellElement cellSize ];
		yourself.
	element addChild: (ToLabel text: aClue printString).
	^ element
]

{ #category : 'building' }
NGSGameElement >> newToolbar [
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
NGSGameElement >> refresh [
	cells do: [ :rowCells |
		rowCells do: [ :cell | (game board atRow: cell row column: cell column) renderOn: cell ] ].
	statusLabel text: (game isSolved ifTrue: [ 'Solved!' ] ifFalse: [ '' ])
]

{ #category : 'actions' }
NGSGameElement >> restart [
	game restart.
	self refresh
]

{ #category : 'initialization' }
NGSGameElement >> setGame: aGame [
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
NGSGameElement >> statusText [
	^ statusLabel text asString
]

{ #category : 'actions' }
NGSGameElement >> undo [
	game undo.
	self refresh
]
