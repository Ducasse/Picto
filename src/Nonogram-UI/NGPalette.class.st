"
I am the pastel color palette and grid metrics of the Nonogram UI.

Responsibility:
- answer every color used by the UI, in one place so they are easy to tweak
- answer the widths of the grid lines: thin between cells, thick every 5 cells, and the board frame

Collaborators: NGCellElement, NGClueElement, NGGameElement and NGIcons use me.

Public API and Key Messages:
- class-side colors: #background, #emptyCell, #filledCell, #gridLine, #crossMark, #errorCell, #satisfiedClueBackground, #satisfiedClueText, #clueText, #cursor, #heart
- class-side layout: #gapAfter:of:, #border

	NGPalette gapAfter: 5 of: 10 >>> 3

Internal Representation and Key Implementation Points.

I have no state: every resource is a class-side method.
"
Class {
	#name : 'NGPalette',
	#superclass : 'Object',
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'colors' }
NGPalette class >> background [
	^ Color fromHexString: 'FDF6EC'
]

{ #category : 'layout' }
NGPalette class >> border [
	"Answer the width of the frame around the board"
	^ 2
]

{ #category : 'colors' }
NGPalette class >> clueText [
	^ Color fromHexString: '5B5F73'
]

{ #category : 'colors' }
NGPalette class >> crossMark [
	^ Color fromHexString: '9A8FB0'
]

{ #category : 'colors' }
NGPalette class >> cursor [
	^ Color fromHexString: 'F4B183'
]

{ #category : 'colors' }
NGPalette class >> emptyCell [
	^ Color white
]

{ #category : 'colors' }
NGPalette class >> errorCell [
	^ Color fromHexString: 'F7C1C1'
]

{ #category : 'colors' }
NGPalette class >> filledCell [
	^ Color fromHexString: '8FA8D8'
]

{ #category : 'layout' }
NGPalette class >> gapAfter: anIndex of: aCount [
	"Answer the width of the grid line after line anIndex: none after the last, thick every 5 lines, thin otherwise"
	anIndex = aCount ifTrue: [ ^ 0 ].
	^ anIndex \\ 5 = 0
		ifTrue: [ 3 ]
		ifFalse: [ 1 ]
]

{ #category : 'colors' }
NGPalette class >> gridLine [
	^ Color fromHexString: 'C9BEDD'
]

{ #category : 'colors' }
NGPalette class >> heart [
	^ Color fromHexString: 'E8919F'
]

{ #category : 'colors' }
NGPalette class >> satisfiedClueBackground [
	^ Color fromHexString: 'D4F0E2'
]

{ #category : 'colors' }
NGPalette class >> satisfiedClueText [
	^ Color fromHexString: '9AA8A0'
]
