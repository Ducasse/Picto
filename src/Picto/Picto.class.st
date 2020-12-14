"
For now Picto only contains the code for the creation of the stripes

### stripe creation rules.
From a matrix of elements, we compute one stripe for each line and row. 
A stripe is composed of a sequence of colored number. 
			
#### Colored numbers			
The numbers represent the number of consecutives cells.
```
	1C => C cell
	2X => XX cell
	
	1C 2X 1R encodes: 			C XX R
```				
				
#### Consecutives	of same color			
3X 3X encodes that the 2 groups of the same color should have at least one space
```
	3X 3X => XXX space + XXX
	
	3X 3X => XXX space XXX
			=> XXX space space XXX
```

#### Consecutives of different colors
We may have multiple space between different colored blocks.
	
	3X 1C 3X 
		=> XXX space* C space* XXX
		=> XXX C XXX
		=> XXX space C XXX	
	
	

"
Class {
	#name : #Picto,
	#superclass : #Object,
	#instVars : [
		'picture',
		'hStripes',
		'vStripes'
	],
	#classVars : [
		'Black',
		'Empty',
		'Green',
		'Red',
		'White',
		'Yellow'
	],
	#category : #Picto
}

{ #category : #initialization }
Picto class >> black [

	^ Black 
]

{ #category : #examples }
Picto class >> cross [
	<sampleInstance>
	
	| a2d |
	a2d := CTArray2D fromArray: 
		{ 
		White . White . Black . White . White . 
		White . White . Black . White . White . 
		Black . Black . Black . Black . Black . 
		White . White . Black . White . White . 
		White . White . Black . White . White
		 }
		 width: 5.
	^ self new 
		picture: a2d;
		yourself
]

{ #category : #initialization }
Picto class >> empty [

	^ Empty 
]

{ #category : #initialization }
Picto class >> green [

	^ Green
]

{ #category : #initialization }
Picto class >> initialize [
	"self initialize"
	Empty := 100.
	White := 0.
	Black := 1.
	Red := 2.
	Green := 3. 
	Yellow := 4.

]

{ #category : #initialization }
Picto class >> red [

	^ Red
]

{ #category : #initialization }
Picto class >> white [

	^ White
]

{ #category : #initialization }
Picto class >> yellow [

	^ Yellow
]

{ #category : #accessing }
Picto >> at: anInteger at: anInteger2 [ 
	^ picture at: anInteger at: anInteger2 
]

{ #category : #accessing }
Picto >> atX: anInteger atY: anInteger2 [ 
  ^ picture atX: anInteger atY: anInteger2 
]

{ #category : #stripes }
Picto >> computeStripes [ 
	
	1 to: picture height do: [ :i | 
		hStripes add: (CTRunArray newFrom: (picture atRow: i)) 	
		]
		
]

{ #category : #stripes }
Picto >> hStripesFor: aLineIndex [

	^ hStripes at: aLineIndex
]

{ #category : #stripes }
Picto >> hStripesFor: aLineIndex group: aGroupIndex [
	"Blue Blue Green Blue Blue is encoded as B2 G1 B2"
	"so group: 2 -> 1"
		
	^ (hStripes at: aLineIndex) runs at: aGroupIndex 
		
]

{ #category : #initialization }
Picto >> initialize [

	super initialize.
	hStripes := OrderedCollection new.
	vStripes := OrderedCollection new.
]

{ #category : #accessing }
Picto >> inspectionPragmas [
	<inspectorPresentationOrder: 30 title: 'Picture'> 

	^ SpTextPresenter new
		text: picture printString;
		yourself
]

{ #category : #accessing }
Picto >> picture: aCTArray2D [ 
	picture := aCTArray2D.
	self computeStripes.
]

{ #category : #stripes }
Picto >> vStripesFor: aLineIndex [

	^ vStripes at: aLineIndex 
]

{ #category : #stripes }
Picto >> vStripesFor: aLineIndex group: aGroupIndex [
	"Blue Blue Green Blue Blue is encoded as B2 G1 B2"
	"so group: 2 -> 1"
		
	^ (vStripes at: aLineIndex) runs at: aGroupIndex 
		
]

{ #category : #accessing }
Picto >> width [
	^ picture width
]
