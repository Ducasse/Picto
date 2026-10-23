Class {
	#name : 'NGSClueTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-Core',
	#package : 'SimpleNonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGSClueTest >> testFromLine [
	self assert: (NGSClue fromLine: #(true true false true)) blocks equals: #(2 1).
	self assert: (NGSClue fromLine: #(false true true true)) blocks equals: #(3).
	self assert: (NGSClue fromLine: #(false false)) isEmpty
]

{ #category : 'tests' }
NGSClueTest >> testPrinting [
	self assert: (NGSClue blocks: #(2 1)) printString equals: '2 1'.
	self assert: (NGSClue blocks: #()) printString equals: '0'
]

{ #category : 'tests' }
NGSClueTest >> testSatisfaction [
	| clue |
	clue := NGSClue blocks: #(1 1).
	self assert: (clue isSatisfiedBy: #(true false true)).
	self deny: (clue isSatisfiedBy: #(true true false)).
	self assert: clue filledCount equals: 2
]
