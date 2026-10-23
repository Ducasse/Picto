"
I test NGClue.
"
Class {
	#name : 'NGClueTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGClueTest >> testFromLine [
	self assert: (NGClue fromLine: #(true true false true)) blocks equals: #(2 1).
	self assert: (NGClue fromLine: #(false true true true)) blocks equals: #(3).
	self assert: (NGClue fromLine: #(false false)) isEmpty
]

{ #category : 'tests' }
NGClueTest >> testPlacements [
	self assert: ((NGClue blocks: #(2 1)) placementsInLength: 5) asSet equals: (Set
		with: #(true true false true false)
		with: #(true true false false true)
		with: #(false true true false true)).
	self assert: ((NGClue blocks: #()) placementsInLength: 2) equals: #(#(false false)).
	self assert: ((NGClue blocks: #(3)) placementsInLength: 2) isEmpty
]

{ #category : 'tests' }
NGClueTest >> testPrinting [
	self assert: (NGClue blocks: #(2 1)) printString equals: '2 1'.
	self assert: (NGClue blocks: #()) printString equals: '0'
]

{ #category : 'tests' }
NGClueTest >> testSatisfaction [
	| clue |
	clue := NGClue blocks: #(1 1).
	self assert: (clue isSatisfiedBy: #(true false true)).
	self deny: (clue isSatisfiedBy: #(true true false)).
	self assert: clue filledCount equals: 2
]
