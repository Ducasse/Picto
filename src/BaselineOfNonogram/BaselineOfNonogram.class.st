"
I am the baseline of the Nonogram game, packaged as the Picto application.

## Responsibility:

- I describe the Nonogram packages and the projects they depend on.
- I define the groups that can be loaded, from the plain model to the packaged application.
- I keep the packaging tools out of the default load.

## Collaborators: 

- Toplo (which brings Bloc) for the UI.
- PharoApplicationGenerator (`ApplicationGenerator`) and `ObjCBridge` for the packaged application only.

## Public API and Key Messages

`#baseline:` with the groups:
- `Core`: the game model (`Nonogram`), plain Pharo
- `UI`: the Bloc and Toplo interface (`Nonogram-UI`)
- `Tests`: `Nonogram-Tests`, testing both
- `App`: the packaged application (`Nonogram-App`, `Nonogram-App-Tests`): `picto` command line, native macOS menu, packaging metadata
- `default`: `Core`, `UI` and `Tests`

```
Metacello new
	baseline: 'Nonogram';
	repository: 'github://Ducasse/Picto:master/src';
	load
```

The build scripts `buildOSX.sh` and `buildWindows.sh` load the groups `App` and `Tests`.

## Internal Representation

I have no state.
"
Class {
	#name : 'BaselineOfNonogram',
	#superclass : 'BaselineOf',
	#category : 'BaselineOfNonogram',
	#package : 'BaselineOfNonogram'
}

{ #category : 'baselines' }
BaselineOfNonogram >> baseline: spec [

	<baseline>
	spec for: #common do: [
			spec baseline: 'Toplo' with: [ spec repository: 'github://pharo-graphics/Toplo:Pharo14/src' ].
			spec baseline: 'ApplicationGenerator' with: [
					spec
						repository: 'github://tesonep/PharoApplicationGenerator:master/src';
						loads: #( 'Core' 'Support' ) ].
			spec baseline: 'ObjCBridge' with: [ spec repository: 'github://tesonep/objcbridge:master/src' ].
			spec
				package: 'Nonogram';
				package: 'Nonogram-UI' with: [ spec requires: #( 'Nonogram' 'Toplo' ) ];
				package: 'Nonogram-Tests' with: [ spec requires: #( 'Nonogram-UI' ) ];
				package: 'Nonogram-App' with: [ spec requires: #( 'Nonogram-UI' 'ApplicationGenerator' 'ObjCBridge' ) ];
				package: 'Nonogram-App-Tests' with: [ spec requires: #( 'Nonogram-App' ) ].
			spec
				group: 'Core' with: #( 'Nonogram' );
				group: 'UI' with: #( 'Nonogram-UI' );
				group: 'Tests' with: #( 'Nonogram-Tests' );
				group: 'App' with: #( 'Nonogram-App' 'Nonogram-App-Tests' );
				group: 'default' with: #( 'Core' 'UI' 'Tests' ) ]
]
