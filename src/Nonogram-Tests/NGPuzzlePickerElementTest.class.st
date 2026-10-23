"
I test NGPuzzlePickerElement.
"
Class {
	#name : 'NGPuzzlePickerElementTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
NGPuzzlePickerElementTest >> testLabelShowsNameAndSize [
	self
		assert: ((NGPuzzlePickerElement on: NGPuzzleLibrary new) labelFor: NGPuzzles greatLighthouse)
		equals: 'Great lighthouse  (20 x 20)'
]

{ #category : 'tests' }
NGPuzzlePickerElementTest >> testLongestLabelFits [
	| widest button |
	widest := NGPuzzle named: (String new: NGPuzzle maxNameSize withAll: $W) fromStrings: (Array new: 20 withAll: (String new: 20 withAll: $#)).
	button := ToButton labelText: ((NGPuzzlePickerElement on: NGPuzzleLibrary new) labelFor: widest).
	button forceLayout.
	self assert: button extent x <= NGPuzzlePickerElement buttonWidth
]

{ #category : 'tests' }
NGPuzzlePickerElementTest >> testOneButtonPerPuzzle [
	| picker |
	picker := NGPuzzlePickerElement on: NGPuzzleLibrary default.
	self assert: picker buttons size equals: picker library size
]

{ #category : 'tests' }
NGPuzzlePickerElementTest >> testPlayOpensAFittedGame [
	| space |
	space := (NGPuzzlePickerElement on: NGPuzzleLibrary new) play: NGPuzzles plus.
	[ self assert: space title equals: 'Plus' ] ensure: [ space close ]
]
