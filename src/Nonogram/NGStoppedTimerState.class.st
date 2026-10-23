"
I am the state of a timer that was stopped; its elapsed time is frozen.
"
Class {
	#name : 'NGStoppedTimerState',
	#superclass : 'NGTimerState',
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'accessing' }
NGStoppedTimerState >> elapsedIn: aTimer [
	^ aTimer endTime - aTimer startTime
]

{ #category : 'state transitions' }
NGStoppedTimerState >> startIn: aTimer [
	^ self
]

{ #category : 'state transitions' }
NGStoppedTimerState >> stopIn: aTimer [
	^ self
]
