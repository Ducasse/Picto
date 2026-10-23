"
I test NGClueElement.
"
Class {
	#name : 'NGClueElementTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
NGClueElementTest >> testColumnClueShowsOneLabelPerBlock [
	| element |
	element := NGClueElement forColumn: (NGClue blocks: #(2 1)).
	self assert: element childrenCount equals: 2.
	self assert: (NGClueElement forColumn: (NGClue blocks: #())) childrenCount equals: 1
]

{ #category : 'tests' }
NGClueElementTest >> testRowClueShowsOneLabel [
	self assert: (NGClueElement forRow: (NGClue blocks: #(2 1))) childrenCount equals: 1
]

{ #category : 'tests' }
NGClueElementTest >> testSatisfiedRendering [
	| element |
	element := NGClueElement forRow: (NGClue blocks: #(3)).
	self assert: element background paint color equals: Color transparent.
	element showSatisfied.
	self assert: element background paint color equals: NGPalette satisfiedClueBackground.
	self assert: element childrenCount equals: 1.
	element showUnsatisfied.
	self assert: element background paint color equals: Color transparent
]

{ #category : 'tests' }
NGClueElementTest >> testUsesCellFontSize [
	| label |
	label := (NGClueElement forRow: (NGClue blocks: #(3))) children first.
	self assert: ((label text attributesAt: 1) anySatisfy: [ :each | each = (BlFontSizeAttribute size: NGCellElement fontSize) ])
]
