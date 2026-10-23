"
I test NGLostState.
"
Class {
	#name : 'NGLostStateTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGLostStateTest >> testIgnoresActions [
	| game |
	game := NGGame on: (NGPuzzle named: 'Dot' fromStrings: #('#.')).
	NGLostState new fillAtRow: 1 column: 1 in: game.
	NGLostState new crossAtRow: 1 column: 2 in: game.
	self assert: game board printString equals: '..'.
	self assert: (NGLostState new statusTextIn: game) equals: 'Game over'
]

{ #category : 'tests' }
NGLostStateTest >> testShowOutcomeShowsOverlay [
	| element |
	element := NGGameElement on: (NGGame on: NGPuzzles plus).
	NGLostState new showOutcomeOn: element for: element game.
	self assert: element overlay isVisible
]
