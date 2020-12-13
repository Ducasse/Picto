Class {
	#name : #BaselineOfPicto,
	#superclass : #BaselineOf,
	#category : #BaselineOfPicto
}

{ #category : #baselines }
BaselineOfPicto >> baseline: spec [
	<baseline>
	spec 
		baseline: 'ContainersArray2D'
		with: [ spec repository: 'github://pharo-containers/Containers-Array2D/src' ].
		
	spec 
		baseline: 'ContainersRunArray'
		with: [ spec repository: 'github://pharo-containers/Containers-RunArray/src' ].
	spec
		for: #pharo
		do: [ 
			spec
				package: 'Picto' with: [ spec requires: #('ContainersArray2D' 'ContainersRunArray') ].
			spec
				package: 'Picto-Tests'
				with: [ spec requires: #('Picto') ] ]
]
