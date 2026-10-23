"
I test NGRevealedEmptyCell.
"
Class {
	#name : 'NGRevealedEmptyCellTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGRevealedEmptyCellTest >> testIsLocked [
	| cell |
	cell := NGRevealedEmptyCell new.
	self deny: cell isFilled.
	self assert: cell afterFill equals: cell.
	self assert: cell afterCross equals: cell.
	self assert: cell afterClear equals: cell.
	self assert: cell printString equals: '!'
]
