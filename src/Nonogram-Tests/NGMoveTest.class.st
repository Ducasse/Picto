Class {
	#name : 'NGMoveTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGMoveTest >> testApplyAndUndo [
	| board move |
	board := NGBoard height: 1 width: 1.
	move := NGMove row: 1 column: 1 from: NGUnknownCell new to: NGFilledCell new.
	move applyTo: board.
	self assert: (board atRow: 1 column: 1) equals: NGFilledCell new.
	move undoOn: board.
	self assert: (board atRow: 1 column: 1) equals: NGUnknownCell new
]
