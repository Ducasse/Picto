"
I am the abstract state of an NGTimer. My subclasses are NGIdleTimerState, NGRunningTimerState and NGStoppedTimerState. The timer delegates start, stop and elapsed to me, so it never has to test whether it was started.
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
