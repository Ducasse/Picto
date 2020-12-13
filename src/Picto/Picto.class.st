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

There is no space between two consecutive groups of different colors.
	3X 1C 3X => XXX C XXX
	

"
Class {
	#name : #Picto,
	#superclass : #Object,
	#instVars : [
		'pictureMatrix'
	],
	#category : #Picto
}
