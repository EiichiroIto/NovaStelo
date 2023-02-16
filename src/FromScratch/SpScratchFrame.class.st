Class {
	#name : #SpScratchFrame,
	#superclass : #SpPresenter,
	#instVars : [
		'viewerPane',
		'stageFrame',
		'editorPane',
		'projectNameLabel',
		'modifiedProjectLabel',
		'logo',
		'menu'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #utilities }
SpScratchFrame class >> alert: aString [

	SpInformDialog new
		title: 'alert!' localized;
		label: aString;
		acceptLabel: 'Close' localized;
		openModal
]

{ #category : #utilities }
SpScratchFrame class >> chooseDirectory: aString [

	^ UIManager default chooseDirectory: aString
]

{ #category : #utilities }
SpScratchFrame class >> chooseExistingFileReference: aString extensions: aCollection path: aFileReference [

	^ UIManager default
		  chooseExistingFileReference: aString
		  extensions: aCollection
		  path: aFileReference
]

{ #category : #utilities }
SpScratchFrame class >> chooseExistingFileReference: aString extensions: aCollection path: aFileReference preview: aClass [

	^ UIManager default
		  chooseExistingFileReference: aString
		  extensions: aCollection
		  path: aFileReference
		  preview: aClass
]

{ #category : #utilities }
SpScratchFrame class >> chooseForSaveFileReference: aString extensions: aCollection path: aFileReference [

	^ UIManager default
		  chooseForSaveFileReference: aString
		  extensions: aCollection
		  path: aFileReference
]

{ #category : #utilities }
SpScratchFrame class >> confirm: aString [

	^ SpConfirmDialog new
		  title: 'Important confirmation' localized;
		  label: aString;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #private }
SpScratchFrame class >> libraryPaneHeight [
	^ self buttonHeight + 23
]

{ #category : #utilities }
SpScratchFrame class >> longMessage: aString title: aString2 [

	UIManager default longMessage: aString title: aString2
]

{ #category : #utilities }
SpScratchFrame class >> multiLineRequest: aString initialAnswer: aString2 [

	^ SpRequestTextDialog new
		  title: 'Information request' localized;
		  label: aString;
		  text: aString2;
		  acceptLabel: 'OK' localized;
		  cancelLabel: 'Cancel' localized;
		  extent: self currentWorld extent // 2;
		  openModal
]

{ #category : #utilities }
SpScratchFrame class >> multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2 [

	^ SpMultiSelectDialog new
		  title: 'Multiple Select' localized;
		  label: aString;
		  items: aCollection;
		  selectedItems: aCollection2;
		  display: [ :each | each ];
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #utilities }
SpScratchFrame class >> request: aString [

	^ SpRequestDialog new
		  title: 'Information request' localized;
		  label: aString;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #utilities }
SpScratchFrame class >> request: aString initialAnswer: aString2 [

	^ SpRequestDialog new
		  title: 'Information request' localized;
		  label: aString;
		  text: aString2;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #utilities }
SpScratchFrame class >> select: aString chooseFrom: aCollection [

	^ SpSelectDialog new
		  title: aString;
		  items: aCollection;
			display: [ :each | each localized ];
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
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

{ #category : #'menu building' }
SpScratchFrame >> addBlockMenu: aMenu for: aBlockMorph [
	aMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'copy' localized;
						action: [ application copyBlock: aBlockMorph ] ];
				addItem: [ :item | 
					item
						name: 'cut' localized;
						action: [ application cutBlock: aBlockMorph ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'delete' localized;
						action: [ aBlockMorph delete ] ];
				addItem: [ :item | 
					item
						name: 'duplicate' localized;
						action: [ application duplicateBlock: aBlockMorph ] ] ]
]

{ #category : #'menu building' }
SpScratchFrame >> addScriptMenu: aMenu for: aScript [

	SpScratchApp clipboard isString ifTrue: [ 
		aMenu addItem: [ :item | 
			item
				name: 'paste' localized;
				action: [ application pasteBlock ] ] ].
	aMenu
		addGroup: [ :grp | 
			grp addItem: [ :item | 
					item
						name: 'add sub block' localized;
						action: [ 
							application
								addSubBlock: self currentWorld cursorPoint
								script: aScript ] ] ];
		addGroup: [ :grp | 
			grp addItem: [ :item | 
				item
					name: 'clean up' localized;
					action: [ aScript cleanUp ] ] ]
]

{ #category : #utilities }
SpScratchFrame >> alert: aString [

	self class alert: aString
]

{ #category : #'menu building' }
SpScratchFrame >> blockMenuFor: aBlockMorph inScriptEditor: aBoolean [

	aBoolean ifFalse: [ ^ nil ].
	^ self newMenu in: [ :m | 
		  self addBlockMenu: m for: aBlockMorph.
		  m ]
]

{ #category : #utilities }
SpScratchFrame >> chooseDirectory: aString [

	^ self class chooseDirectory: aString
]

{ #category : #utilities }
SpScratchFrame >> chooseExistingFileReference: aString extensions: aCollection path: aFileReference [

	^ self class
		  chooseExistingFileReference: aString
		  extensions: aCollection
		  path: aFileReference
]

{ #category : #utilities }
SpScratchFrame >> chooseExistingFileReference: aString extensions: aCollection path: aFileReference preview: aClass [

	^ self class
		  chooseExistingFileReference: aString
		  extensions: aCollection
		  path: aFileReference
		  preview: aClass
]

{ #category : #utilities }
SpScratchFrame >> chooseForSaveFileReference: aString extensions: aCollection path: aFileReference [

	^ self class
		  chooseForSaveFileReference: aString
		  extensions: aCollection
		  path: aFileReference
]

{ #category : #utilities }
SpScratchFrame >> confirm: aString [

	^ self class confirm: aString
]

{ #category : #accessing }
SpScratchFrame >> currentCategory [

	^ viewerPane currentCategory
]

{ #category : #accessing }
SpScratchFrame >> currentCategory: aString [
	viewerPane currentCategory: aString
]

{ #category : #private }
SpScratchFrame >> defaultExtent [
	self subclassResponsibility
]

{ #category : #private }
SpScratchFrame >> display [
	^ stageFrame display
]

{ #category : #'menu building' }
SpScratchFrame >> examplesMenu [
	| m |
	m := self newMenu.
	application exampleFiles
		do: [ :each | 
			m
				addItem: [ :item | 
					item
						name: each basename;
						action: [ application loadExample: each ] ] ].
	^ m
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

{ #category : #'menu building' }
SpScratchFrame >> helpMenu [

	^ self newMenu
		  addItem: [ :item | 
			  item
				  name: ('About ' , application appName) localized;
				  action: [ owner window showAbout ] ];
		  addItem: [ :item | 
			  item
				  name: 'Restart';
				  action: [ stageFrame startStepping ] ];
		  addItem: [ :item | 
			  item
				  name: 'Inspect';
				  enabled: [ self settings hideDebugMenu not ];
				  action: [ application inspect ] ];
		  addItem: [ :item | 
			  item
				  name: 'Settings';
				  enabled: [ self settings hideDebugMenu not ];
				  subMenu: self settingsMenu ];
		  yourself
]

{ #category : #accessing }
SpScratchFrame >> info: aString [
	self display info: aString
]

{ #category : #initialization }
SpScratchFrame >> initializePresenters [

	logo := self newLogo.
	menu := self newMenuBar.
	viewerPane := self newViewer.
	editorPane := self newEditor.
	projectNameLabel := self newLabel.
	stageFrame := self newStage.
	modifiedProjectLabel := self newLabel.
	self setupMenu
]

{ #category : #initialization }
SpScratchFrame >> initializeWindow: aWindow [
	aWindow
		initialExtent: self defaultExtent;
		aboutText: application class aboutAppString;
		whenClosedDo: [ application windowClosing ]
]

{ #category : #utilities }
SpScratchFrame >> longMessage: aString title: aString2 [

	self class longMessage: aString title: aString2
]

{ #category : #accessing }
SpScratchFrame >> modifiedText [

	^ modifiedProjectLabel label
]

{ #category : #accessing }
SpScratchFrame >> modifiedText: aString [

	modifiedProjectLabel label: aString
]

{ #category : #utilities }
SpScratchFrame >> multiLineRequest: aString initialAnswer: aString2 [

	^ self class multiLineRequest: aString initialAnswer: aString2
]

{ #category : #utilities }
SpScratchFrame >> multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2 [

	^ self class multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2
]

{ #category : #initialization }
SpScratchFrame >> newEditor [

	^ self newMorph
		  morph: self newEditorMorph;
		  yourself
]

{ #category : #initialization }
SpScratchFrame >> newEditorMorph [

	^ ScrollFrameMorph new
		  growthFraction: 0.1;
		  color: ScratchTheme scriptsPaneColor;
		  yourself
]

{ #category : #initialization }
SpScratchFrame >> newLogo [

	^ self newImage
		  image: (ScratchTheme formAt: #logo);
		  yourself
]

{ #category : #initialization }
SpScratchFrame >> newStage [

	self subclassResponsibility
]

{ #category : #initialization }
SpScratchFrame >> newViewer [

	^ self instantiate: SpScratchListViewer
]

{ #category : #private }
SpScratchFrame >> privEditor [
	^ editorPane
]

{ #category : #private }
SpScratchFrame >> privStage [
	^ stageFrame
]

{ #category : #accessing }
SpScratchFrame >> projectName [

	^ projectNameLabel label
]

{ #category : #accessing }
SpScratchFrame >> projectName: aString [

	projectNameLabel label: aString
]

{ #category : #utilities }
SpScratchFrame >> request: aString [

	^ self class request: aString
]

{ #category : #utilities }
SpScratchFrame >> request: aString initialAnswer: aString2 [

	^ self class request: aString initialAnswer: aString2
]

{ #category : #accessing }
SpScratchFrame >> scriptForm [
	^ editorPane screenshot
]

{ #category : #'menu building' }
SpScratchFrame >> scriptMenuFor: aScript [

	^ self newMenu in: [ :m | 
		  self addScriptMenu: m for: aScript.
		  m ]
]

{ #category : #utilities }
SpScratchFrame >> select: aString chooseFrom: aCollection [

	^ self class select: aString chooseFrom: aCollection
]

{ #category : #accessing }
SpScratchFrame >> settings [

	^ self application settings
]

{ #category : #'menu building' }
SpScratchFrame >> settingsMenu [

	| m |
	m := self newMenu.
	m addGroup: [ :grp | 
		self application settingKeys do: [ :key | 
			grp addItem: [ :item | 
				item
					name: key , ' = ' , (application settingAt: key) asString;
					action: [ 
						application selectSetting: key.
						self updateWindowSettings.
						item name: key , ' = ' , (application settingAt: key) asString ] ] ] ].
	m addGroup: [ :grp | 
		grp addItem: [ :item | 
			item
				name: 'Save settings' localized;
				action: [ application saveSettings ] ] ].
	^ m
]

{ #category : #initialization }
SpScratchFrame >> setupMenu [

	self subclassResponsibility
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
	self display
		stepTime: anInteger;
		startStepping
]

{ #category : #accessing }
SpScratchFrame >> tab: aString [
	editorPane tab: aString
]

{ #category : #accessing }
SpScratchFrame >> target [
	^ viewerPane target
]

{ #category : #accessing }
SpScratchFrame >> target: aScript [
	viewerPane target: aScript.
	editorPane target: aScript
]

{ #category : #accessing }
SpScratchFrame >> updateContents [
	viewerPane updateContents
]

{ #category : #accessing }
SpScratchFrame >> updateDisplay [
	self display changed
]

{ #category : #private }
SpScratchFrame >> updateWindowSettings [

	| win |
	Display isFullscreen
		ifTrue: [ 
		self settings fullscreen ifFalse: [ Display fullscreenOff ] ]
		ifFalse: [ 
		self settings fullscreen ifTrue: [ Display fullscreenOn ] ].
	win := self window window.
	self settings dontClose
		ifTrue: [ win makeUnclosable ]
		ifFalse: [ win makeClosable ].
	self settings stickyWindow
		ifTrue: [ win beSticky ]
		ifFalse: [ win beUnsticky ].
	self settings resizable
		ifTrue: [ 
			self window beResizable.
			self window withDecorations ]
		ifFalse: [ 
			self window beNotResizable.
			self window withoutDecorations ]
]

{ #category : #stepping }
SpScratchFrame >> whenStepsDo: aBlock [
	self display
		whenStepsDo: aBlock;
		startStepping
]
