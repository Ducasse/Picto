"
I am the `picto` command line entry point of the packaged Picto application.

In Pharo 14, command lines are handled by Clap: I declare my specification with a `<commandline>` pragma, so `./pharo Picto.image picto` launches the game.

## Responsibility:

- I declare the `picto` command and its `--embedded` flag, which the PharoApplicationGenerator launcher always passes.
- I keep the image running after the command line is processed.
- I delegate the launch to `NGApplication`.

## Collaborators: 

- `ClapCommandSpec` describes my command line.
- `NGApplication` launches the game.

## Public API and Key Messages

- `NGPictoCommand class >> #commandSpecification` answers my Clap specification.
- `NGPictoCommand class >> #commandName` answers `'picto'`, the name used in the application metadata.
- `#execute` runs the command.

```
./pharo Picto.image picto
```

Run `NGPictoCommand class >> #scriptCommandLine` to see how my command line is matched.

## Internal Representation

My state is held by Clap (`ClapApplication`).
"
Class {
	#name : 'NGPictoCommand',
	#superclass : 'ClapPharoApplication',
	#category : 'Nonogram-App',
	#package : 'Nonogram-App'
}

{ #category : 'command line' }
NGPictoCommand class >> commandName [
	"The command name given to PharoApplicationGenerator as CommandLineHandler"

	^ 'picto'
]

{ #category : 'command line' }
NGPictoCommand class >> commandSpecification [

	<commandline>
	^ (ClapCommandSpec id: self commandName asSymbol)
		  description: 'Launch Picto, a simple nonogram game developed in Pharo';
		  commandClass: self;
		  addHelp;
		  addFlag: #embedded description: 'run as a packaged application (passed by the PharoApplicationGenerator launcher)';
		  yourself
]

{ #category : 'script' }
NGPictoCommand class >> scriptCommandLine [
	"Show how the command lines 'picto', 'picto --embedded' and 'picto --unknown' are matched, without launching the game."

	<script>
	(#( #( 'picto' ) #( 'picto' '--embedded' ) #( 'picto' '--unknown' ) ) collect: [ :arguments |
			 (' ' join: arguments) -> (ClapContext withPragmaCommands
				  arguments: arguments;
				  yourself) match isValid ]) inspect
]

{ #category : 'execution' }
NGPictoCommand >> execute [

	self doNotQuitImage.
	NGApplication new launch
]
