"
I record one change of a cell on a board so that it can be undone.
"
Class {
	#name : 'NGMove',
	#superclass : 'Object',
	#instVars : [
		'row',
		'column',
		'previousState',
		'newState'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGMove class >> row: aRow column: aColumn from: aPreviousState to: aNewState [
	^ self new setRow: aRow column: aColumn from: aPreviousState to: aNewState
]

{ #category : 'operations' }
NGMove >> applyTo: aBoard [
	aBoard atRow: row column: column put: newState
]

{ #category : 'accessing' }
NGMove >> column [
	^ column
]

{ #category : 'accessing' }
NGMove >> newState [
	^ newState
]

{ #category : 'accessing' }
NGMove >> previousState [
	^ previousState
]

{ #category : 'accessing' }
NGMove >> row [
	^ row
]

{ #category : 'initialization' }
NGMove >> setRow: aRow column: aColumn from: aPreviousState to: aNewState [
	row := aRow.
	column := aColumn.
	previousState := aPreviousState.
	newState := aNewState
]

{ #category : 'operations' }
NGMove >> undoOn: aBoard [
	aBoard atRow: row column: column put: previousState
]
