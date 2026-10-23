"
I am the clue of one row or column: the ordered lengths of the runs of filled cells.

Responsibility:
- describe a line and tell whether a line satisfies me
- enumerate every line of a given length satisfying me
- tell whether the beginning of a line can still be completed to satisfy me

Collaborators: NGPuzzle builds me; NGSolver uses my placements and prefix test.

Public API and Key Messages:
- NGClue class >> #fromLine: and #blocks: create me
- #blocks, #isEmpty, #filledCount, #isSatisfiedBy:
- #placementsInLength:, #acceptsPrefix:inLength:

	(NGClue fromLine: #(true true false true)) blocks >>> #(2 1)

Internal Representation and Key Implementation Points.

Instance Variables
	blocks:		<Array of Integers> the run lengths; empty for an empty line, printed as 0
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

{ #category : 'solving' }
NGClue >> acceptsPrefix: aCollectionOfBooleans inLength: aLength [
	"Answer whether the first cells of a line of aLength cells can still be completed to satisfy me"
	| completed run remaining needed |
	completed := OrderedCollection new.
	run := 0.
	aCollectionOfBooleans do: [ :filled |
		filled
			ifTrue: [ run := run + 1 ]
			ifFalse: [
				run > 0 ifTrue: [ completed add: run ].
				run := 0 ] ].
	completed size > blocks size ifTrue: [ ^ false ].
	(blocks first: completed size) = completed asArray ifFalse: [ ^ false ].
	remaining := blocks allButFirst: completed size.
	run > 0
		ifTrue: [
			remaining ifEmpty: [ ^ false ].
			run > remaining first ifTrue: [ ^ false ].
			needed := remaining first - run + (remaining allButFirst inject: 0 into: [ :sum :each | sum + each + 1 ]) ]
		ifFalse: [ needed := (remaining inject: 0 into: [ :sum :each | sum + each + 1 ]) - 1 max: 0 ].
	^ needed <= (aLength - aCollectionOfBooleans size)
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

{ #category : 'solving' }
NGClue >> placementsInLength: aLength [
	"Answer every line of aLength Booleans whose runs of true values are exactly my blocks"
	^ self placementsOfBlocks: blocks inLength: aLength
]

{ #category : 'private' }
NGClue >> placementsOfBlocks: aSequence inLength: aLength [
	| first rest minimumRest placements |
	aSequence ifEmpty: [ ^ Array with: (Array new: aLength withAll: false) ].
	first := aSequence first.
	rest := aSequence allButFirst.
	minimumRest := (rest inject: 0 into: [ :sum :each | sum + each + 1 ]).
	placements := OrderedCollection new.
	0 to: aLength - first - minimumRest do: [ :offset |
		| prefix |
		prefix := (Array new: offset withAll: false) , (Array new: first withAll: true).
		rest
			ifEmpty: [ placements add: prefix , (Array new: aLength - prefix size withAll: false) ]
			ifNotEmpty: [
				(self placementsOfBlocks: rest inLength: aLength - prefix size - 1)
					do: [ :tail | placements add: prefix , #( false ) , tail ] ] ].
	^ placements asArray
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
