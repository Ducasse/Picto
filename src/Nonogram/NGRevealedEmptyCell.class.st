"
I represent a cell the player wrongly filled: the fill was refused and I reveal that the cell is empty. I am locked: fill, cross and clear leave me unchanged.
"
Class {
	#name : 'NGRevealedEmptyCell',
	#superclass : 'NGCellState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterClear [
	^ self
]

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterCross [
	^ self
]

{ #category : 'transitions' }
NGRevealedEmptyCell >> afterFill [
	^ self
]

{ #category : 'printing' }
NGRevealedEmptyCell >> character [
	^ $!
]

{ #category : 'rendering' }
NGRevealedEmptyCell >> renderOn: aCellElement [
	aCellElement showRevealedEmpty
]
