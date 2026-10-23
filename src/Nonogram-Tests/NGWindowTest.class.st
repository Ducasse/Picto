"
I test NGWindow.
"
Class {
	#name : 'NGWindowTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-UI',
	#package : 'Nonogram-Tests',
	#tag : 'UI'
}

{ #category : 'tests' }
NGWindowTest >> testOpenFitsElement [
	| element space |
	element := BlElement new extent: 120 @ 80; yourself.
	space := NGWindow open: element titled: 'Test'.
	[ self assert: space extent equals: 120 @ 80.
	self assert: space title equals: 'Test' ] ensure: [ space close ]
]
