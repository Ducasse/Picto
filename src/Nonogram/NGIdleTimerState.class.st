"
I am the state of a timer that has not been started yet.
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
