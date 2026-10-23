"
I am the state of a timer that is counting.
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
