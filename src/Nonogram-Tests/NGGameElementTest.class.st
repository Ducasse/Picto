"
I test NGGameElement.
"
Class {
	#name : 'NGGameElementTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'fixtures' }
NGGameElementTest >> element [
	^ NGGameElement on: (NGGame on: (NGPuzzle named: 'Plus' fromStrings: #('.#.' '###' '.#.')))
]

{ #category : 'tests' }
NGGameElementTest >> testCellsAreBuilt [
	| element |
	element := self element.
	self assert: (element cellAtRow: 3 column: 3) row equals: 3.
	self assert: (element cellAtRow: 1 column: 1) background paint color equals: Color white.
	self assert: element statusText equals: ''
]

{ #category : 'tests' }
NGGameElementTest >> testClickMovesCursor [
	| element |
	element := self element.
	(element cellAtRow: 3 column: 2) dispatchEvent: (BlPrimaryClickEvent new button: BlMouseButton primary; yourself).
	self assert: (element cursor isAtRow: 3 column: 2)
]

{ #category : 'tests' }
NGGameElementTest >> testErrorsShowLivesAndGameOver [
	| element |
	element := self element.
	self assert: (element livesElement children collect: [ :each | each background paint color ]) asArray
		equals: (Array new: 3 withAll: NGPalette heart).
	element fillAtRow: 1 column: 1.
	self assert: element livesElement childrenCount equals: 3.
	self assert: element livesElement children last background paint color equals: Color transparent.
	self assert: (element cellAtRow: 1 column: 1) background paint color equals: NGPalette errorCell.
	element fillAtRow: 1 column: 3; fillAtRow: 3 column: 1.
	self assert: element statusText equals: 'Game over'
]

{ #category : 'tests' }
NGGameElementTest >> testKeyboardMovesCursorAndPlays [
	| element |
	element := self element.
	self assert: (element cellAtRow: 1 column: 1) border width equals: 2.
	element dispatchEvent: (BlKeyDownEvent new key: KeyboardKey right; yourself).
	element dispatchEvent: (BlKeyDownEvent new key: KeyboardKey down; yourself).
	self assert: (element cursor isAtRow: 2 column: 2).
	self assert: (element cellAtRow: 2 column: 2) border width equals: 2.
	self assert: (element cellAtRow: 1 column: 1) border width equals: 0.
	element dispatchEvent: (BlKeyDownEvent new key: KeyboardKey space; yourself).
	self assert: (element game board atRow: 2 column: 2) equals: NGFilledCell new.
	element dispatchEvent: (BlKeyDownEvent new key: KeyboardKey X; yourself).
	self assert: (element game board atRow: 2 column: 2) equals: NGCrossedCell new.
	element dispatchEvent: (BlKeyDownEvent new key: KeyboardKey backspace; yourself).
	self assert: (element game board atRow: 2 column: 2) equals: NGUnknownCell new
]

{ #category : 'tests' }
NGGameElementTest >> testLossShowsOverlay [
	| element |
	element := self element.
	self deny: element overlay isVisible.
	element fillAtRow: 1 column: 1; fillAtRow: 1 column: 3; fillAtRow: 3 column: 1.
	self assert: element overlay isVisible.
	self deny: element banner isVisible.
	element restart.
	self deny: element overlay isVisible
]

{ #category : 'tests' }
NGGameElementTest >> testOpenSizesWindowToFit [
	| element space |
	element := self element.
	space := element open.
	[ self assert: space extent equals: element extent.
	self assert: space title equals: 'Plus' ] ensure: [ space close ]
]

{ #category : 'tests' }
NGGameElementTest >> testPrimaryClickFills [
	| element cell |
	element := self element.
	cell := element cellAtRow: 2 column: 2.
	cell dispatchEvent: (BlPrimaryClickEvent new button: BlMouseButton primary; yourself).
	self assert: (element game board atRow: 2 column: 2) equals: NGFilledCell new.
	self assert: cell background paint color equals: NGPalette filledCell
]

{ #category : 'tests' }
NGGameElementTest >> testSatisfiedCluesAreHighlighted [
	| element |
	element := self element.
	self assert: (element rowClueElementAt: 1) background paint color equals: Color transparent.
	element fillAtRow: 1 column: 2.
	self assert: (element rowClueElementAt: 1) background paint color equals: NGPalette satisfiedClueBackground.
	self assert: (element columnClueElementAt: 2) background paint color equals: Color transparent.
	element fillAtRow: 1 column: 2.
	self assert: (element rowClueElementAt: 1) background paint color equals: Color transparent
]

{ #category : 'tests' }
NGGameElementTest >> testSecondaryClickCrosses [
	| element cell |
	element := self element.
	cell := element cellAtRow: 1 column: 1.
	cell dispatchEvent: (BlSecondaryClickEvent new button: BlMouseButton secondary; yourself).
	self assert: (element game board atRow: 1 column: 1) equals: NGCrossedCell new.
	self assert: cell childrenCount equals: 1
]

{ #category : 'tests' }
NGGameElementTest >> testSolvingAndRestart [
	| element |
	element := self element.
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p | element fillAtRow: p first column: p second ].
	self assert: (element statusText beginsWith: 'Solved in ').
	element restart.
	self assert: element statusText equals: ''
]

{ #category : 'tests' }
NGGameElementTest >> testTimerLabel [
	self assert: self element timerText equals: '00:00'
]

{ #category : 'tests' }
NGGameElementTest >> testWinShowsBanner [
	| element |
	element := self element.
	self deny: element banner isVisible.
	#(#(1 2) #(2 1) #(2 2) #(2 3) #(3 2)) do: [ :p | element fillAtRow: p first column: p second ].
	self assert: element banner isVisible.
	self deny: element overlay isVisible.
	element restart.
	self deny: element banner isVisible
]
