"
I test NGTimer.
"
Class {
	#name : 'NGTimerTest',
	#superclass : 'TestCase',
	#instVars : [
		'time'
	],
	#category : 'Nonogram-Tests-Core',
	#package : 'Nonogram-Tests',
	#tag : 'Core'
}

{ #category : 'helpers' }
NGTimerTest >> advance: seconds [
	time := time + seconds seconds
]

{ #category : 'running' }
NGTimerTest >> setUp [
	super setUp.
	time := DateAndTime year: 2026 month: 1 day: 1
]

{ #category : 'tests' }
NGTimerTest >> testIdleTimerShowsZero [
	| timer |
	timer := self timer.
	self advance: 10.
	self assert: timer elapsed equals: Duration zero.
	self assert: timer printElapsed equals: '00:00'
]

{ #category : 'tests' }
NGTimerTest >> testMinutesGoBeyondAnHour [
	| timer |
	timer := self timer.
	timer start.
	self advance: 75 * 60 + 12.
	self assert: timer printElapsed equals: '75:12'
]

{ #category : 'tests' }
NGTimerTest >> testReset [
	| timer |
	timer := self timer.
	timer start.
	self advance: 30.
	timer stop; reset.
	self assert: timer elapsed equals: Duration zero.
	timer start.
	self advance: 3.
	self assert: timer elapsed equals: 3 seconds
]

{ #category : 'tests' }
NGTimerTest >> testRunningTimerCounts [
	| timer |
	timer := self timer.
	timer start.
	self advance: 65.
	self assert: timer elapsed equals: 65 seconds.
	self assert: timer printElapsed equals: '01:05'
]

{ #category : 'tests' }
NGTimerTest >> testStartTwiceKeepsFirstStart [
	| timer |
	timer := self timer.
	timer start.
	self advance: 5.
	timer start.
	self advance: 5.
	self assert: timer elapsed equals: 10 seconds
]

{ #category : 'tests' }
NGTimerTest >> testStoppedTimerIsFrozen [
	| timer |
	timer := self timer.
	timer start.
	self advance: 30.
	timer stop.
	self advance: 30.
	timer start.
	self assert: timer elapsed equals: 30 seconds
]

{ #category : 'helpers' }
NGTimerTest >> timer [
	^ NGTimer clock: [ time ]
]
