Class {
	#name : 'NGUnknownCellTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGUnknownCellTest >> testTransitions [
	self assert: NGUnknownCell new afterFill equals: NGFilledCell new.
	self assert: NGUnknownCell new afterCross equals: NGCrossedCell new.
	self deny: NGUnknownCell new isFilled
]
