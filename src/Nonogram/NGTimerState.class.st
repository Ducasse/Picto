"
I am the abstract state of an NGTimer.

Responsibility: answer the state reached on start and on stop, and the elapsed time of the timer.

Collaborators: NGTimer; my subclasses NGIdleTimerState, NGRunningTimerState and NGStoppedTimerState.

Public API and Key Messages: #startIn:, #stopIn:, #elapsedIn:

	NGIdleTimerState new elapsedIn: aTimer >>> Duration zero

Internal Representation and Key Implementation Points.

I have no instance variables.
"
Class {
	#name : 'NGTimerState',
	#superclass : 'Object',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'accessing' }
NGTimerState >> elapsedIn: aTimer [
	^ self subclassResponsibility
]

{ #category : 'state transitions' }
NGTimerState >> startIn: aTimer [
	"Return the state reached when aTimer is started"
	^ self subclassResponsibility
]

{ #category : 'state transitions' }
NGTimerState >> stopIn: aTimer [
	"Return the state reached when aTimer is stopped"
	^ self subclassResponsibility
]
