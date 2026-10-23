"
I test NGCrossedCell.
"
Class {
	#name : 'NGCrossedCellTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGCrossedCellTest >> testTransitions [
	self assert: NGCrossedCell new afterFill equals: NGFilledCell new.
	self assert: NGCrossedCell new afterCross equals: NGUnknownCell new.
	self deny: NGCrossedCell new isFilled
]
