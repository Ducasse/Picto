"
I am the clue of one row or column: the ordered lengths of the runs of filled cells. An empty line has the clue (0) printed, but my blocks are empty.

	(NGSClue fromLine: #(true true false true)) blocks >>> #(2 1)
"
Class {
	#name : 'NGSClue',
	#superclass : 'Object',
	#instVars : [
		'blocks'
	],
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGSClue class >> blocks: anArray [
	^ self new setBlocks: anArray
]

{ #category : 'instance creation' }
NGSClue class >> fromLine: aCollectionOfBooleans [
	"Build the clue describing the runs of true values in the line"
	| blocks run |
	blocks := OrderedCollection new.
	run := 0.
	aCollectionOfBooleans do: [ :filled |
		filled
			ifTrue: [ run := run + 1 ]
			ifFalse: [
				run > 0 ifTrue: [ blocks add: run ].
				run := 0 ] ].
	run > 0 ifTrue: [ blocks add: run ].
	^ self blocks: blocks asArray
]

{ #category : 'comparing' }
NGSClue >> = anObject [
	^ self class = anObject class and: [ blocks = anObject blocks ]
]

{ #category : 'accessing' }
NGSClue >> blocks [
	^ blocks
]

{ #category : 'accessing' }
NGSClue >> filledCount [
	^ blocks inject: 0 into: [ :sum :each | sum + each ]
]

{ #category : 'comparing' }
NGSClue >> hash [
	^ blocks hash
]

{ #category : 'testing' }
NGSClue >> isEmpty [
	^ blocks isEmpty
]

{ #category : 'testing' }
NGSClue >> isSatisfiedBy: aCollectionOfBooleans [
	^ self = (self class fromLine: aCollectionOfBooleans)
]

{ #category : 'printing' }
NGSClue >> printOn: aStream [
	blocks isEmpty ifTrue: [ ^ aStream nextPut: $0 ].
	blocks do: [ :each | aStream print: each ] separatedBy: [ aStream space ]
]

{ #category : 'initialization' }
NGSClue >> setBlocks: anArray [
	blocks := anArray
]
