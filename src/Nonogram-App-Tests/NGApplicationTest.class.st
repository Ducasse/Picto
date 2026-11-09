"
I test `NGApplication`: the metadata given to PharoApplicationGenerator and the content of the native macOS menu.
"
Class {
	#name : 'NGApplicationTest',
	#superclass : 'TestCase',
	#instVars : [
		'application'
	],
	#category : 'Nonogram-App-Tests',
	#package : 'Nonogram-App-Tests'
}

{ #category : 'running' }
NGApplicationTest >> runCaseManaged [

	"I need to skip the collection of background processes errors during the execution of #testClosingTheMainWindowQuits"
	
	^ testSelector = #testClosingTheMainWindowQuits 
		ifTrue: [ self runCase ]
		ifFalse: [ super runCaseManaged ]

]

{ #category : 'tests' }
NGApplicationTest >> setUp [

	super setUp.
	application := NGApplication new
]

{ #category : 'tests' }
NGApplicationTest >> testAboutTextGivesNameAndDescription [

	self assert: (application aboutText includesSubstring: 'Picto 1.0.0').
	self assert: (application aboutText includesSubstring: application infoString)
]

{ #category : 'tests' }
NGApplicationTest >> testClosingTheMainWindowQuits [
	"Bloc delivers the close event on a later pulse, so wait for it (at most 2 seconds)"

	| quitted space |
	quitted := false.
	application quitBlock: [ quitted := true ].
	space := application openMainWindow.
	[
		self assert: space root children first class equals: NGPuzzlePickerElement.
		self deny: quitted.
		space close.
		20 timesRepeat: [ quitted ifFalse: [ (Delay forMilliseconds: 100) wait ] ].
		self assert: quitted ] ensure: [ space isOpened ifTrue: [ space close ] ]
]

{ #category : 'tests' }
NGApplicationTest >> testContextAnswersMethodPropertiesForObjCBridge [
	"ObjCBridge builds its Cocoa callouts with Context>>#methodProperties; Pharo 14 removed it, so the native macOS menu failed"

	| properties |
	properties := thisContext methodProperties.
	self assert: properties isMethodProperties.
	self assert: properties selector equals: #testContextAnswersMethodPropertiesForObjCBridge
]

{ #category : 'tests' }
NGApplicationTest >> testEmbeddedModeCanBeAsked [
	"AppGeneratorSupport class>>#isEmbedded sends #argumentsInclude: to Smalltalk; Pharo 14 removed it, so the launch failed. The test image is not started with --embedded."

	self deny: AppGeneratorSupport isEmbedded.
	self assert: (Smalltalk argumentsInclude: '--embedded') equals: (Smalltalk arguments includes: '--embedded')
]

{ #category : 'tests' }
NGApplicationTest >> testIconsAreReadFromResources [

	self assert: application iconSetFile parent basename equals: 'resources'.
	self assert: application iconFile parent equals: application iconSetFile parent
]

{ #category : 'tests' }
NGApplicationTest >> testMacMenuIsBuiltWithoutTouchingCocoa [

	self assert: application macMenu class equals: CocoaMenu.
	self assert: application macMenu nsMenu isNil
]

{ #category : 'tests' }
NGApplicationTest >> testOSXPropertiesDescribePicto [

	| properties |
	properties := application osxProperties.
	self assert: (properties at: #AppName) equals: 'Picto'.
	self assert: (properties at: #DisplayName) equals: 'Picto'.
	self assert: (properties at: #InfoString) equals: 'Picto is a simple nonogram game developed in Pharo'.
	self assert: (properties at: #BundleIdentifier) equals: 'org.pharo.picto'.
	self assert: (properties at: #ShortVersion) equals: '1.0.0'.
	self assert: (properties at: #IconSetFile) basename equals: 'Picto.icns'
]

{ #category : 'tests' }
NGApplicationTest >> testPropertiesLaunchThePictoCommand [

	self assert: (application osxProperties at: #CommandLineHandler) equals: NGPictoCommand commandName.
	self assert: (application windowsProperties at: #CommandLineHandler) equals: NGPictoCommand commandName
]

{ #category : 'tests' }
NGApplicationTest >> testPuzzleMenuItemsListTheLibrary [

	| library items |
	library := NGPuzzleLibrary default.
	items := application puzzleMenuItems.
	self assert: (items collect: #key) asArray equals: (library puzzles collect: #name) asArray.
	self assert: (items collect: [ :each | each value name ]) asArray equals: (library puzzles collect: #name) asArray
]

{ #category : 'tests' }
NGApplicationTest >> testSessionAnswersReadOnlyAccessMode [
	"AppGenerator-Support overrides SmalltalkImage>>#snapshot:andQuit: and sends #isReadOnlyAccessMode to the session; Pharo 14 removed it, so saving or quitting failed"

	self deny: SessionManager default currentSession isReadOnlyAccessMode
]

{ #category : 'tests' }
NGApplicationTest >> testWindowsPropertiesDescribePicto [

	| properties |
	properties := application windowsProperties.
	self assert: (properties at: #AppName) equals: 'Picto'.
	self assert: (properties at: #InfoString) equals: 'Picto is a simple nonogram game developed in Pharo'.
	self assert: (properties at: #IconFile) basename equals: 'Picto.ico'.
	self assert: (properties at: #CompanyName) equals: 'Pharo Consortium'.
	self assert: ((properties at: #LegalCopyright) includesSubstring: '2026')
]
