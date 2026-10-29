"
I am the state of a timer that has not been started.

## Responsibility:

- On start, I mark the start time and make the timer running.
- I ignore stop.
- I answer a zero elapsed time.

## Collaborators:

- `NGTimer` delegates to me.
- `NGRunningTimerState` is the state I lead to.

## Public API and Key Messages

- `#startIn:`, `#stopIn:`, `#elapsedIn:`

```
NGIdleTimerState new startIn: aTimer
```

## Internal Representation

I have no instance variables.
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
