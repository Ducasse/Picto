"
I test NGIdleTimerState.
"
Class {
	#name : 'NGIdleTimerStateTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'tests' }
NGIdleTimerStateTest >> testTransitions [
	| timer |
	timer := NGTimer clock: [ DateAndTime year: 2026 month: 1 day: 1 ].
	self assert: (NGIdleTimerState new startIn: timer) class equals: NGRunningTimerState.
	self assert: (NGIdleTimerState new stopIn: timer) class equals: NGIdleTimerState.
	self assert: (NGIdleTimerState new elapsedIn: timer) equals: Duration zero
]
