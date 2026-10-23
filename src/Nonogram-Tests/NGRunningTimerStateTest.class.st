"
I test NGRunningTimerState.
"
Class {
	#name : 'NGRunningTimerStateTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGRunningTimerStateTest >> testTransitions [
	| time timer |
	time := DateAndTime year: 2026 month: 1 day: 1.
	timer := NGTimer clock: [ time ].
	timer markStart.
	time := time + 4 seconds.
	self assert: (NGRunningTimerState new elapsedIn: timer) equals: 4 seconds.
	self assert: (NGRunningTimerState new startIn: timer) class equals: NGRunningTimerState.
	self assert: (NGRunningTimerState new stopIn: timer) class equals: NGStoppedTimerState
]
