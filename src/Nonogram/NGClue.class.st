"
I am the clue of one row or column: the ordered lengths of the runs of filled cells. An empty line has the clue (0) printed, but my blocks are empty.

	(NGClue fromLine: #(true true false true)) blocks >>> #(2 1)
"
Class {
	#name : 'NGClue',
	#superclass : 'Object',
	#instVars : [
		'blocks'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGClue class >> blocks: anArray [
	^ self new setBlocks: anArray
]

{ #category : 'instance creation' }
NGClue class >> fromLine: aCollectionOfBooleans [
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
NGClue >> = anObject [
	^ self class = anObject class and: [ blocks = anObject blocks ]
]

{ #category : 'accessing' }
NGClue >> blocks [
	^ blocks
]

{ #category : 'accessing' }
NGClue >> filledCount [
	^ blocks inject: 0 into: [ :sum :each | sum + each ]
]

{ #category : 'comparing' }
NGClue >> hash [
	^ blocks hash
]

{ #category : 'testing' }
NGClue >> isEmpty [
	^ blocks isEmpty
]

{ #category : 'testing' }
NGClue >> isSatisfiedBy: aCollectionOfBooleans [
	^ self = (self class fromLine: aCollectionOfBooleans)
]

{ #category : 'printing' }
NGClue >> printOn: aStream [
	blocks isEmpty ifTrue: [ ^ aStream nextPut: $0 ].
	blocks do: [ :each | aStream print: each ] separatedBy: [ aStream space ]
]

{ #category : 'initialization' }
NGClue >> setBlocks: anArray [
	blocks := anArray
]
