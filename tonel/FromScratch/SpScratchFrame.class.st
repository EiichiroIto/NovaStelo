Class {
	#name : #SpScratchFrame,
	#superclass : #SpPresenter,
	#instVars : [
		'viewerPane',
		'libraryPane',
		'stageFrame',
		'titlePane',
		'editorPane'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #private }
SpScratchFrame class >> libraryPaneHeight [
	^ self buttonHeight + 23
]

{ #category : #private }
SpScratchFrame class >> titleButtonHeight [
	^ 23 + 10
]

{ #category : #private }
SpScratchFrame class >> viewerPaneWidth [
	^ 214
]

{ #category : #private }
SpScratchFrame class >> workPaneHeight [
	^ 600
]

{ #category : #private }
SpScratchFrame class >> workPaneWidth [
	^ 600
]

{ #category : #private }
SpScratchFrame >> aboutTitle [
	^ application appName
]

{ #category : #accessing }
SpScratchFrame >> currentCategory: aString [
	viewerPane currentCategory: aString
]

{ #category : #accessing }
SpScratchFrame >> currentTab: aString [
	editorPane currentTab: aString
]

{ #category : #accessing }
SpScratchFrame >> currentTarget [
	^ editorPane target
]

{ #category : #accessing }
SpScratchFrame >> currentTarget: aScript [
	editorPane target: aScript.
	viewerPane target: aScript
]

{ #category : #private }
SpScratchFrame >> defaultExtent [
	self subclassResponsibility
]

{ #category : #private }
SpScratchFrame >> display [
	^ stageFrame display
]

{ #category : #private }
SpScratchFrame >> formFrom: aMorph extent: size [
	| canvas thumbForm bounds |
	bounds := aMorph modelBounds.
	canvas := FormCanvas extent: bounds extent depth: 32.
	canvas
		translateBy: bounds topLeft negated
		during: [ :c | aMorph fullDrawOn: c ].
	thumbForm := Form extent: size depth: 32.
	(WarpBlt toForm: thumbForm)
		sourceForm: canvas form;
		cellSize: 2;
		combinationRule: Form over;
		copyQuad: (0 @ 0 extent: canvas extent) innerCorners
			toRect: thumbForm boundingBox.
	^ thumbForm
]

{ #category : #accessing }
SpScratchFrame >> info: aString [
	self display info: aString
]

{ #category : #initialization }
SpScratchFrame >> initializeWindow: aWindow [
	aWindow
		initialExtent: self defaultExtent;
		aboutText: application aboutAppString
]

{ #category : #accessing }
SpScratchFrame >> projectName [
	^ titlePane projectName
]

{ #category : #accessing }
SpScratchFrame >> projectName: aString [
	titlePane projectName: aString
]

{ #category : #accessing }
SpScratchFrame >> scriptForm [
	^ editorPane screenshot
]

{ #category : #private }
SpScratchFrame >> stageShotExtent: size [
	^ self formFrom: self display extent: size
]

{ #category : #stepping }
SpScratchFrame >> stepTime [
	^ self display stepTime
]

{ #category : #stepping }
SpScratchFrame >> stepTime: anInteger [
	self display stepTime: anInteger
]

{ #category : #accessing }
SpScratchFrame >> target: aScript [
	viewerPane target: aScript.
	editorPane target: aScript.
	libraryPane selectButton: aScript objName
]

{ #category : #accessing }
SpScratchFrame >> updateContents [
	viewerPane updateContents
]

{ #category : #accessing }
SpScratchFrame >> updateDisplay [
	self display changed
]

{ #category : #stepping }
SpScratchFrame >> whenStepsDo: aBlock [
	self display
		whenStepsDo: aBlock;
		startStepping
]
