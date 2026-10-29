"
I am the state of a stopped timer: its elapsed time is frozen.

## Responsibility:

- I ignore start.
- I ignore stop.
- I answer the time between start and end.

## Collaborators:

- `NGTimer` delegates to me.

## Public API and Key Messages

- `#startIn:`, `#stopIn:`, `#elapsedIn:`

```
NGStoppedTimerState new elapsedIn: aTimer
```

## Internal Representation

I have no instance variables.

### Implementation Points

- Only a reset of the timer leaves me.
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
