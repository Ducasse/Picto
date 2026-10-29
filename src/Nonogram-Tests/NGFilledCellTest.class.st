"
I test NGFilledCell.
"
Class {
	#name : 'NGFilledCellTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGFilledCellTest >> testAfterWin [
	self assert: NGFilledCell new afterWin equals: NGFilledCell new
]

{ #category : 'tests' }
NGFilledCellTest >> testTransitions [
	self assert: NGFilledCell new afterFill equals: NGUnknownCell new.
	self assert: NGFilledCell new afterCross equals: NGCrossedCell new.
	self assert: NGFilledCell new isFilled.

]
