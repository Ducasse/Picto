"
I route unhandled errors of the packaged application to PharoApplicationGenerator's error handler.

PharoApplicationGenerator hooks its error handler on `CommandLineUIManager`, which does not exist anymore in Pharo 14. I plug the same behavior into Pharo 14's `ErrorHandler` mechanism.

## Responsibility:

- I first give an unhandled error to the application handler (by default `AppGeneratorSupport unhandledErrorDefaultAction:`).
- When the application handler does not handle it, I pass the error to a fallback error handler.
- I am never selected automatically: the application installs me explicitly.

## Collaborators: 

- `AppGeneratorSupport` decides, when the application is embedded, how to report the error (e.g. `AppGeneratorSDLMessageErrorHandler` shows a message box and quits).
- `ErrorHandler` is the fallback; by default the handler that was installed before me.

## Public API and Key Messages

- `NGAppErrorHandler class >> #install` installs a new instance as `ErrorHandler default`.
- `#handleError:log:` routes an error.
- `#appHandler:` sets a block taking the error and answering whether it was handled; `#fallbackHandler:` sets the fallback.

```
NGAppErrorHandler install
```

See `NGAppErrorHandler class >> #exampleDefault`.

## Internal Representation

- `appHandler`: <BlockClosure> takes the error, answers a Boolean: true when handled.
- `fallbackHandler`: <ErrorHandler> handles what `appHandler` did not.
"
Class {
	#name : 'NGAppErrorHandler',
	#superclass : 'ErrorHandler',
	#instVars : [
		'appHandler',
		'fallbackHandler'
	],
	#category : 'Nonogram-App',
	#package : 'Nonogram-App'
}

{ #category : 'examples' }
NGAppErrorHandler class >> exampleDefault [

	<sampleInstance>
	^ self new
]

{ #category : 'installing' }
NGAppErrorHandler class >> install [
	"Install a new instance as the system error handler. It falls back to the handler installed before it, captured before the replacement."

	| handler |
	handler := self new.
	handler fallbackHandler.
	ErrorHandler default: handler.
	^ handler
]

{ #category : 'testing' }
NGAppErrorHandler class >> isValidForCurrentSystemConfiguration [
	"I am installed explicitly by the application, never chosen from the system configuration"

	^ false
]

{ #category : 'accessing' }
NGAppErrorHandler >> appHandler [

	^ appHandler ifNil: [ appHandler := [ :error | AppGeneratorSupport unhandledErrorDefaultAction: error ] ]
]

{ #category : 'accessing' }
NGAppErrorHandler >> appHandler: aBlock [

	appHandler := aBlock
]

{ #category : 'accessing' }
NGAppErrorHandler >> fallbackHandler [

	^ fallbackHandler ifNil: [ fallbackHandler := ErrorHandler default ]
]

{ #category : 'accessing' }
NGAppErrorHandler >> fallbackHandler: anErrorHandler [

	fallbackHandler := anErrorHandler
]

{ #category : 'error handling' }
NGAppErrorHandler >> handleError: anError log: shouldLog [
	"Give anError to the application handler; when it does not handle it, pass it to the fallback handler"

	(self appHandler value: anError) ifTrue: [ ^ self ].
	self fallbackHandler handleError: anError log: shouldLog
]

{ #category : 'error handling' }
NGAppErrorHandler >> handleNotification: aNotification [

	self fallbackHandler handleNotification: aNotification
]

{ #category : 'error handling' }
NGAppErrorHandler >> handleWarning: aWarning [

	self fallbackHandler handleWarning: aWarning
]

{ #category : 'error handling' }
NGAppErrorHandler >> handleWarningDebugRequest: aWarningDebugRequest fromDebuggerSystem: aDebuggerSystem [

	self fallbackHandler handleWarningDebugRequest: aWarningDebugRequest fromDebuggerSystem: aDebuggerSystem
]

{ #category : 'error handling' }
NGAppErrorHandler >> onPrimitiveError: aString [

	self fallbackHandler onPrimitiveError: aString
]
