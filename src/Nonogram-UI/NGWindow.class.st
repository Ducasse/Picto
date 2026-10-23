"
I open Nonogram elements in their own window.

Responsibility: open an element in a new titled window on the palette background, and keep the window fitting the element when its size changes.

Collaborators: NGGameElement and NGPuzzlePickerElement open through me; NGPalette gives the background.

Public API and Key Messages:
- class-side #open:titled: answers the opened BlSpace

	NGWindow open: (NGGameElement on: (NGGame on: NGPuzzles plus)) titled: 'Plus'

Internal Representation and Key Implementation Points.

I have no state. The element is laid out before opening to size the window, then a BlElementExtentChangedEvent handler resizes the window once text and icons are measured.
"
Class {
	#name : 'NGWindow',
	#superclass : 'Object',
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'opening' }
NGWindow class >> open: anElement titled: aString [
	"Open anElement in a new window titled aString that keeps fitting its size"
	| space |
	anElement forceLayout.
	space := BlSpace new.
	space
		title: aString;
		extent: anElement extent ceiling.
	space root
		background: NGPalette background;
		addChild: anElement.
	anElement
		addEventHandlerOn: BlElementExtentChangedEvent
		do: [ :event | space extent: anElement extent ceiling ].
	space show.
	^ space
]
