"
I test NGStoppedTimerState.
"
Class {
	#name : 'NGStoppedTimerStateTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGStoppedTimerStateTest >> testTransitions [
	| time timer |
	time := DateAndTime year: 2026 month: 1 day: 1.
	timer := NGTimer clock: [ time ].
	timer markStart.
	time := time + 4 seconds.
	timer markEnd.
	time := time + 10 seconds.
	self assert: (NGStoppedTimerState new elapsedIn: timer) equals: 4 seconds.
	self assert: (NGStoppedTimerState new startIn: timer) class equals: NGStoppedTimerState.
	self assert: (NGStoppedTimerState new stopIn: timer) class equals: NGStoppedTimerState
]
