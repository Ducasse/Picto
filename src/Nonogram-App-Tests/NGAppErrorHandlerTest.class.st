"
I test that `NGAppErrorHandler` gives errors to the application handler first and to its fallback otherwise. I use `NGRecordingErrorHandler` as fallback so no test can quit the image.
"
Class {
	#name : 'NGAppErrorHandlerTest',
	#superclass : 'TestCase',
	#instVars : [
		'fallback'
	],
	#category : 'Nonogram-App-Tests',
	#package : 'Nonogram-App-Tests'
}

{ #category : 'tests' }
NGAppErrorHandlerTest >> handlerAnswering: aBoolean [

	^ NGAppErrorHandler new
		  appHandler: [ :error | aBoolean ];
		  fallbackHandler: fallback;
		  yourself
]

{ #category : 'tests' }
NGAppErrorHandlerTest >> setUp [

	super setUp.
	fallback := NGRecordingErrorHandler new
]

{ #category : 'tests' }
NGAppErrorHandlerTest >> testApplicationHandlerReceivesTheError [

	| error received |
	error := Error new.
	NGAppErrorHandler new
		appHandler: [ :e |
				received := e.
				true ];
		fallbackHandler: fallback;
		handleError: error log: false.
	self assert: received identicalTo: error
]

{ #category : 'tests' }
NGAppErrorHandlerTest >> testDefaultFallbackIsTheCurrentHandler [

	self assert: NGAppErrorHandler new fallbackHandler identicalTo: ErrorHandler default
]

{ #category : 'tests' }
NGAppErrorHandlerTest >> testErrorHandledByTheApplicationIsNotPassedOn [

	(self handlerAnswering: true) handleError: Error new log: false.
	self assert: fallback errors isEmpty
]

{ #category : 'tests' }
NGAppErrorHandlerTest >> testErrorNotHandledByTheApplicationGoesToTheFallback [

	| error |
	error := Error new.
	(self handlerAnswering: false) handleError: error log: false.
	self assert: fallback errors asArray equals: { error }
]

{ #category : 'tests' }
NGAppErrorHandlerTest >> testIsNeverChosenAutomatically [

	self deny: NGAppErrorHandler isValidForCurrentSystemConfiguration
]

{ #category : 'tests' }
NGAppErrorHandlerTest >> testWarningsGoToTheFallback [

	| warning |
	warning := Warning new.
	(self handlerAnswering: true) handleWarning: warning.
	self assert: fallback errors asArray equals: { warning }
]
