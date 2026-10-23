"
I am the state of a timer that has not been started.

Responsibility: on start, mark the start time and become running; ignore stop; answer a zero elapsed time.

Collaborators: NGTimer, NGRunningTimerState.

Public API and Key Messages: #startIn:, #stopIn:, #elapsedIn:

	NGIdleTimerState new startIn: aTimer

Internal Representation and Key Implementation Points.

I have no instance variables.
"
Class {
	#name : 'NGIdleTimerState',
	#superclass : 'NGTimerState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'accessing' }
NGIdleTimerState >> elapsedIn: aTimer [
	^ Duration zero
]

{ #category : 'state transitions' }
NGIdleTimerState >> startIn: aTimer [
	aTimer markStart.
	^ NGRunningTimerState new
]

{ #category : 'state transitions' }
NGIdleTimerState >> stopIn: aTimer [
	^ self
]
