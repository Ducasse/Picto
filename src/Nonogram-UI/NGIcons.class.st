"
I am the catalog of vector icons of the Nonogram UI.

Responsibility:
- keep the SVG path data of each icon in a class-side resource method
- build Bloc elements drawing these icons with the palette colors

Collaborators: NGPalette for the colors; NGCellElement uses the cross; NGGameElement uses the hearts.

Public API and Key Messages:
- class-side resources: #crossPath, #heartPath, #size
- class-side icons: #cross, #fullHeart, #emptyHeart

	NGIcons fullHeart

Internal Representation and Key Implementation Points.

I have no state. Bloc does not scale SVG paths, so every path is drawn in a #size x #size box and the icon elements have that extent.
"
Class {
	#name : 'NGIcons',
	#superclass : 'Object',
	#category : 'Nonogram-UI-Core',
	#package : 'Nonogram-UI',
	#tag : 'Core'
}

{ #category : 'icons' }
NGIcons class >> cross [
	^ (self iconFor: self crossPath)
		background: NGPalette crossMark;
		yourself
]

{ #category : 'resources' }
NGIcons class >> crossPath [
	"SVG path of a cross in a 24 x 24 box"
	^ 'M6 4 L12 10 L18 4 L20 6 L14 12 L20 18 L18 20 L12 14 L6 20 L4 18 L10 12 L4 6 Z'
]

{ #category : 'icons' }
NGIcons class >> emptyHeart [
	^ (self iconFor: self heartPath)
		background: Color transparent;
		border: (BlBorder paint: NGPalette heart width: 1.5);
		yourself
]

{ #category : 'icons' }
NGIcons class >> fullHeart [
	^ (self iconFor: self heartPath)
		background: NGPalette heart;
		yourself
]

{ #category : 'resources' }
NGIcons class >> heartPath [
	"SVG path of a heart in a 24 x 24 box"
	^ 'M12 21 L10.6 19.7 C5.4 15 2 11.9 2 8.1 C2 5 4.4 2.6 7.5 2.6 C9.2 2.6 10.9 3.4 12 4.7 C13.1 3.4 14.8 2.6 16.5 2.6 C19.6 2.6 22 5 22 8.1 C22 11.9 18.6 15 13.4 19.7 Z'
]

{ #category : 'private' }
NGIcons class >> iconFor: aPathString [
	^ BlElement new
		geometry: (BlSvgPath new pathString: aPathString; yourself);
		extent: self size asPoint;
		yourself
]

{ #category : 'resources' }
NGIcons class >> size [
	"Answer the side of the square box in which every icon path is drawn"
	^ 24
]
