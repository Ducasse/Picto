"
I measure the time a player spends on a puzzle. I am idle until started, then running until stopped. My clock is a block answering the current DateAndTime, so tests can inject a fake one.

	NGTimer new start; elapsed
"
Class {
	#name : 'NGTimer',
	#superclass : 'Object',
	#instVars : [
		'clock',
		'state',
		'startTime',
		'endTime'
	],
	#category : 'Nonogram-Core',
	#package : 'Nonogram',
	#tag : 'Core'
}

{ #category : 'instance creation' }
NGTimer class >> clock: aBlock [
	"aBlock answers the current DateAndTime"
	^ self basicNew initialize setClock: aBlock
]

{ #category : 'instance creation' }
NGTimer class >> new [
	^ self clock: [ DateAndTime now ]
]

{ #category : 'accessing' }
NGTimer >> elapsed [
	^ state elapsedIn: self
]

{ #category : 'accessing' }
NGTimer >> endTime [
	^ endTime
]

{ #category : 'private' }
NGTimer >> markEnd [
	endTime := self now
]

{ #category : 'private' }
NGTimer >> markStart [
	startTime := self now
]

{ #category : 'accessing' }
NGTimer >> now [
	^ clock value
]

{ #category : 'printing' }
NGTimer >> printElapsed [
	"Answer the elapsed time as mm:ss; minutes go beyond 59 rather than showing hours"
	| seconds |
	seconds := self elapsed asSeconds.
	^ String streamContents: [ :stream |
		stream
			nextPutAll: ((seconds // 60) printPaddedWith: $0 to: 2);
			nextPut: $:;
			nextPutAll: ((seconds \\ 60) printPaddedWith: $0 to: 2) ]
]

{ #category : 'actions' }
NGTimer >> reset [
	state := NGIdleTimerState new
]

{ #category : 'initialization' }
NGTimer >> setClock: aBlock [
	clock := aBlock.
	self reset
]

{ #category : 'actions' }
NGTimer >> start [
	state := state startIn: self
]

{ #category : 'accessing' }
NGTimer >> startTime [
	^ startTime
]

{ #category : 'actions' }
NGTimer >> stop [
	state := state stopIn: self
]
