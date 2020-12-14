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

	| picto |
	picto := self classUnderTest cross.
	"White white Black white white"
	self assert: (picto hStripesFor: 1) runs size equals: 3.
	"Black Black Black Black Black"
	self assert: (picto hStripesFor: 3) runs size equals: 1.
	self assert: (picto hStripesFor: 3 group: 1) equals: 5.
]

{ #category : #tests }
PtoHorizontalStripeTest >> testPictoReadyForTest [

	| pict |
	pict := self classUnderTest cross.
	self assert: pict width equals: 5.
	self assert: (pict atX: 3 atY: 3) equals: pict class black
]
