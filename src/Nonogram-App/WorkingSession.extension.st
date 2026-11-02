Extension { #name : 'WorkingSession' }

{ #category : '*Nonogram-App' }
WorkingSession >> isReadOnlyAccessMode [
	"PharoApplicationGenerator (AppGenerator-Support) overrides SmalltalkImage>>#snapshot:andQuit: and sends me; Pharo 14 removed me. Pharo 14 has no read-only image mode, and the packaged application never saves its image."

	^ false
]
