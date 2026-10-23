Class {
	#name : 'NGSUnknownCellTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-Core',
	#package : 'SimpleNonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGSUnknownCellTest >> testTransitions [
	self assert: NGSUnknownCell new afterFill equals: NGSFilledCell new.
	self assert: NGSUnknownCell new afterCross equals: NGSCrossedCell new.
	self deny: NGSUnknownCell new isFilled
]
