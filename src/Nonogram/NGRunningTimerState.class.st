"
I am the state of a timer that is counting.

## Responsibility:

- I ignore start.
- On stop, I mark the end time and make the timer stopped.
- I answer the time since the start.

## Collaborators:

- `NGTimer` delegates to me.
- `NGStoppedTimerState` is the state I lead to.

## Public API and Key Messages

- `#startIn:`, `#stopIn:`, `#elapsedIn:`

```
NGRunningTimerState new elapsedIn: aTimer
```

## Internal Representation

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
