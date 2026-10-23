"
I record one change of a cell on a board so that it can be undone.
"
Class {
	#name : 'NGSMove',
	#superclass : 'Object',
	#instVars : [
		'row',
		'column',
		'previousState',
		'newState'
	],
	#category : 'SimpleNonogram-Core',
	#package : 'SimpleNonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGSMove class >> row: aRow column: aColumn from: aPreviousState to: aNewState [
	^ self new setRow: aRow column: aColumn from: aPreviousState to: aNewState
]

{ #category : 'operations' }
NGSMove >> applyTo: aBoard [
	aBoard atRow: row column: column put: newState
]

{ #category : 'accessing' }
NGSMove >> column [
	^ column
]

{ #category : 'accessing' }
NGSMove >> newState [
	^ newState
]

{ #category : 'accessing' }
NGSMove >> previousState [
	^ previousState
]

{ #category : 'accessing' }
NGSMove >> row [
	^ row
]

{ #category : 'initialization' }
NGSMove >> setRow: aRow column: aColumn from: aPreviousState to: aNewState [
	row := aRow.
	column := aColumn.
	previousState := aPreviousState.
	newState := aNewState
]

{ #category : 'operations' }
NGSMove >> undoOn: aBoard [
	aBoard atRow: row column: column put: previousState
]
