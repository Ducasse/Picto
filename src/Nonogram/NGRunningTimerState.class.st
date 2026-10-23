"
I am the state of a timer that is counting.

Responsibility: ignore start; on stop, mark the end time and become stopped; answer the time since the start.

Collaborators: NGTimer, NGStoppedTimerState.

Public API and Key Messages: #startIn:, #stopIn:, #elapsedIn:

	NGRunningTimerState new elapsedIn: aTimer

Internal Representation and Key Implementation Points.

I have no instance variables.
"
Class {
	#name : 'NGRunningTimerState',
	#superclass : 'NGTimerState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'accessing' }
NGRunningTimerState >> elapsedIn: aTimer [
	^ aTimer now - aTimer startTime
]

{ #category : 'state transitions' }
NGRunningTimerState >> startIn: aTimer [
	^ self
]

{ #category : 'state transitions' }
NGRunningTimerState >> stopIn: aTimer [
	aTimer markEnd.
	^ NGStoppedTimerState new
]
