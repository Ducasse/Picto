Class {
	#name : 'NGSCrossedCellTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-Core',
	#package : 'SimpleNonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGSCrossedCellTest >> testTransitions [
	self assert: NGSCrossedCell new afterFill equals: NGSFilledCell new.
	self assert: NGSCrossedCell new afterCross equals: NGSUnknownCell new.
	self deny: NGSCrossedCell new isFilled
]
