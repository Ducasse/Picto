Extension { #name : 'SmalltalkImage' }

{ #category : '*Nonogram-App' }
SmalltalkImage >> argumentsInclude: aString [
	"PharoApplicationGenerator (AppGeneratorSupport class>>#isEmbedded) sends me to detect --embedded; Pharo 14 removed me"

	^ self arguments includes: aString
]
