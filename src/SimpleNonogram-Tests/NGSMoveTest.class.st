Class {
	#name : 'NGSMoveTest',
	#superclass : 'TestCase',
	#category : 'SimpleNonogram-Tests-Core',
	#package : 'SimpleNonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGSMoveTest >> testApplyAndUndo [
	| board move |
	board := NGSBoard height: 1 width: 1.
	move := NGSMove row: 1 column: 1 from: NGSUnknownCell new to: NGSFilledCell new.
	move applyTo: board.
	self assert: (board atRow: 1 column: 1) equals: NGSFilledCell new.
	move undoOn: board.
	self assert: (board atRow: 1 column: 1) equals: NGSUnknownCell new
]
