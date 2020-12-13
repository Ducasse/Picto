Class {
	#name : #PtoHorizontalStripeTest,
	#superclass : #TestCase,
	#category : #'Picto-Tests'
}

{ #category : #tests }
PtoHorizontalStripeTest >> testContiguousGeneratesOnSingleBlock [

	| pict |
	pict := self class firstLineContiguous.
	self assert: (pict hStripesFor: 1) size equals: 1.
]
