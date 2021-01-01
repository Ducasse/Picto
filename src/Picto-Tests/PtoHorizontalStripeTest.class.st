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
PtoHorizontalStripeTest >> cross [

	^ self classUnderTest cross
	
]

{ #category : #tests }
PtoHorizontalStripeTest >> testAccessingInformation [

	| picto aStripe |
	picto := self cross.
	"White white Black white white"
	aStripe := picto hStripesFor: 1.
	self assert: aStripe runs size equals: 3.
	self assert: (aStripe runs at: 1) equals: 2.
	self assert: (aStripe values at: 1) equals: self classUnderTest white.
	self assert: (aStripe values at: 2) equals: self classUnderTest black
	
]

{ #category : #tests }
PtoHorizontalStripeTest >> testAccessingInformation2 [

	| picto aStripe |
	self skip.
	picto := self classUnderTest cross.
	"black black Black black black"
	aStripe := picto hStripesFor: 3.
	self assert: aStripe runs size equals: 1.
	self assert: (aStripe runs at: 1) equals: 5.
	self assert: (aStripe values at: 1) equals: self classUnderTest black.
	self assert: (aStripe values at: 2) equals: self classUnderTest black.
	self assert: (aStripe values at: 3) equals: self classUnderTest black
	
	"This test show that the API of RunArray is not done to query a value of given index."
]

{ #category : #tests }
PtoHorizontalStripeTest >> testContiguousGeneratesOnSingleBlock [

	| picto |
	picto := self cross.
	"White white Black white white"
	self assert: (picto hStripesFor: 1) runs size equals: 3.
	"Black Black Black Black Black"
	self assert: (picto hStripesFor: 3) runs size equals: 1.
	self assert: (picto hStripesFor: 3 group: 1) equals: 5.
]

{ #category : #tests }
PtoHorizontalStripeTest >> testPictoReadyForTest [

	| pict |
	pict := self cross.
	self assert: pict width equals: 5.
	self assert: (pict atX: 3 atY: 3) equals: pict class black
]
