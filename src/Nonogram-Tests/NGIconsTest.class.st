"
I test NGIcons.
"
Class {
	#name : 'NGIconsTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
NGIconsTest >> testIcons [
	| cross |
	cross := NGIcons cross.
	cross forceLayout.
	self assert: cross extent equals: NGIcons size asPoint.
	self assert: cross background paint color equals: NGPalette crossMark.
	self assert: NGIcons fullHeart background paint color equals: NGPalette heart.
	self assert: NGIcons emptyHeart border width equals: 1.5
]
