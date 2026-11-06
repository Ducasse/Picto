Extension { #name : 'Context' }

{ #category : '*Nonogram-App' }
Context >> methodProperties [
	"ObjCBridge (ObjCCalloutMethodBuilder>>#generateFFICallout:spec:) sends me to copy the pragmas of the method being replaced; Pharo 14 removed me"

	^ self method properties
]
