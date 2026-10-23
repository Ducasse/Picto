"
I test NGPalette.
"
Class {
	#name : 'NGPaletteTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
NGPaletteTest >> testColorsAreDistinct [
	| colors |
	colors := #(#background #emptyCell #filledCell #gridLine #crossMark #errorCell #satisfiedClueBackground #clueText #cursor #heart) collect: [ :each | NGPalette perform: each ].
	self assert: colors asSet size equals: colors size
]

{ #category : 'tests' }
NGPaletteTest >> testGaps [
	self assert: (NGPalette gapAfter: 1 of: 10) equals: 1.
	self assert: (NGPalette gapAfter: 5 of: 10) equals: 3.
	self assert: (NGPalette gapAfter: 10 of: 10) equals: 0
]
