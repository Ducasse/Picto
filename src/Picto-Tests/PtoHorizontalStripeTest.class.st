Class {
	#name : #PtoHorizontalStripeTest,
	#superclass : #TestCase,
	#category : #'Picto-Tests'
}

{ #category : #tests }
PtoHorizontalStripeTest >> classUnderTest [
	^ Picto
]

{ #category : #tests }
PtoHorizontalStripeTest >> testContiguousGeneratesOnSingleBlock [

	| pict |
	self skip.
	pict := self classUnderTest firstLineContiguous.
	self assert: (pict hStripesFor: 1) size equals: 1.
]

{ #category : #tests }
PtoHorizontalStripeTest >> testPictoReadyForTest [

	| pict |
	pict := self classUnderTest cross.
	self assert: pict width equals: 5.
	self assert: (pict atX: 3 atY: 3) equals: pict class black
]
