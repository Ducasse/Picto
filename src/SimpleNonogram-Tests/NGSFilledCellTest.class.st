Class {
	#name : 'NGSFilledCellTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-Core',
	#package : 'SimpleNonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGSFilledCellTest >> testTransitions [
	self assert: NGSFilledCell new afterFill equals: NGSUnknownCell new.
	self assert: NGSFilledCell new afterCross equals: NGSCrossedCell new.
	self assert: NGSFilledCell new isFilled.
	self assert: NGSFilledCell new printString equals: '#'
]
