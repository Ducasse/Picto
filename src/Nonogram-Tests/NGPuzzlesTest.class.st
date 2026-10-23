"
I test NGPuzzles.
"
Class {
	#name : 'NGPuzzlesTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGPuzzlesTest >> testEveryPuzzleHasUniqueSolution [
	(Pragma allNamed: #puzzle in: NGPuzzles class) do: [ :pragma |
		self assert: (NGPuzzles perform: pragma methodSelector) hasUniqueSolution ]
]
