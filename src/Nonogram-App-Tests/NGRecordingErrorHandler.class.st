"
I am a test double error handler: I record the errors I receive instead of handling them.

## Responsibility:

- I record each error given to `#handleError:log:`.
- I never open a debugger or quit the image.

## Collaborators: 

- `NGAppErrorHandlerTest` uses me as the fallback of `NGAppErrorHandler`.

## Public API and Key Messages

- `#handleError:log:` records the error.
- `#errors` answers the recorded errors.

See `NGRecordingErrorHandler class >> #exampleDefault`.

## Internal Representation

- `errors`: <OrderedCollection> the errors received, in order.
"
Class {
	#name : 'NGRecordingErrorHandler',
	#superclass : 'ErrorHandler',
	#instVars : [
		'errors'
	],
	#category : 'Nonogram-App-Tests',
	#package : 'Nonogram-App-Tests'
}

{ #category : 'examples' }
NGRecordingErrorHandler class >> exampleDefault [

	<sampleInstance>
	^ self new
]

{ #category : 'testing' }
NGRecordingErrorHandler class >> isValidForCurrentSystemConfiguration [

	^ false
]

{ #category : 'error handling' }
NGRecordingErrorHandler >> errors [

	^ errors ifNil: [ errors := OrderedCollection new ]
]

{ #category : 'error handling' }
NGRecordingErrorHandler >> handleError: anError log: shouldLog [

	self errors add: anError
]

{ #category : 'error handling' }
NGRecordingErrorHandler >> handleWarning: aWarning [

	self errors add: aWarning
]

{ #category : 'error handling' }
NGRecordingErrorHandler >> handleWarningDebugRequest: aWarningDebugRequest fromDebuggerSystem: aDebuggerSystem [

	self errors add: aWarningDebugRequest
]
