"
I test that `NGPictoCommand` declares the `picto` command line, including the `--embedded` flag passed by the PharoApplicationGenerator launcher.
"
Class {
	#name : 'NGPictoCommandTest',
	#superclass : 'TestCase',
	#category : 'Nonogram-App-Tests',
	#package : 'Nonogram-App-Tests'
}

{ #category : 'tests' }
NGPictoCommandTest >> clapContextEnsuringPictoCommands [

	"If we are running the tests with coverage, the pragmas does not work. A the pragmas filter out the non installed methods (coverage uses wrappers, real methods are never installed)."
	
	| ctx |
	ctx := ClapContext withPragmaCommands.
	(ctx specification subcommands anySatisfy: [ :s | s commandClass = NGPictoCommand ])
			ifTrue: [ ^ ctx ].
			
	ctx specification add: (NGPictoCommand commandSpecification).
	
	^ ctx	
]

{ #category : 'tests' }
NGPictoCommandTest >> matchOf: arguments [

	^ (self clapContextEnsuringPictoCommands
		   arguments: arguments;
		   yourself) match
]

{ #category : 'tests' }
NGPictoCommandTest >> testCommandNameIsPicto [

	self assert: NGPictoCommand commandName equals: 'picto'
]

{ #category : 'tests' }
NGPictoCommandTest >> testPictoIsAValidCommandLine [

	self assert: (self matchOf: #( 'picto' )) isValid
]

{ #category : 'tests' }
NGPictoCommandTest >> testPictoWithEmbeddedFlagIsAValidCommandLine [
	"The PharoApplicationGenerator launcher always runs: picto --embedded"
	self assert: (self matchOf: #( 'picto' '--embedded' )) isValid
]

{ #category : 'tests' }
NGPictoCommandTest >> testPictoWithUnknownFlagIsRejected [

	self deny: (self matchOf: #( 'picto' '--unknown' )) isValid
]
