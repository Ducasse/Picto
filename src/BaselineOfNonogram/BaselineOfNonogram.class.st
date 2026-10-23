"
I am the baseline of the Nonogram game.

Responsibility: describe the Nonogram packages, their dependencies and the groups that can be loaded.

Collaborators: Toplo (which brings Bloc) for the UI.

Public API and Key Messages: #baseline: with the groups
- Core: the game model (Nonogram), plain Pharo
- UI: the Bloc and Toplo interface (Nonogram-UI)
- Tests: Nonogram-Tests, testing both
- default: everything

	Metacello new
		baseline: 'Nonogram';
		repository: 'github://Ducasse/Picto:master/src';
		load

Internal Representation and Key Implementation Points.

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
		spec
			package: 'Nonogram';
			package: 'Nonogram-UI' with: [ spec requires: #( 'Nonogram' 'Toplo' ) ];
			package: 'Nonogram-Tests' with: [ spec requires: #( 'Nonogram-UI' ) ].
		spec
			group: 'Core' with: #( 'Nonogram' );
			group: 'UI' with: #( 'Nonogram-UI' );
			group: 'Tests' with: #( 'Nonogram-Tests' );
			group: 'default' with: #( 'Core' 'UI' 'Tests' ) ]
]
