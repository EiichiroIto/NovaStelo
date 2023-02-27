Class {
	#name : #SpScratchPresenter,
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
SpScratchPresenter class >> alert: aString [

	SpInformDialog new
		title: 'alert!' localized;
		label: aString;
		acceptLabel: 'Close' localized;
		openModal
]

{ #category : #utilities }
SpScratchPresenter class >> chooseDirectory: aString [

	^ UIManager default chooseDirectory: aString
]

{ #category : #utilities }
SpScratchPresenter class >> chooseExistingFileReference: aString extensions: aCollection path: aFileReference [

	^ UIManager default
		  chooseExistingFileReference: aString
		  extensions: aCollection
		  path: aFileReference
]

{ #category : #utilities }
SpScratchPresenter class >> chooseExistingFileReference: aString extensions: aCollection path: aFileReference preview: aClass [

	^ UIManager default
		  chooseExistingFileReference: aString
		  extensions: aCollection
		  path: aFileReference
		  preview: aClass
]

{ #category : #utilities }
SpScratchPresenter class >> chooseForSaveFileReference: aString extensions: aCollection path: aFileReference [

	^ UIManager default
		  chooseForSaveFileReference: aString
		  extensions: aCollection
		  path: aFileReference
]

{ #category : #utilities }
SpScratchPresenter class >> confirm: aString [

	^ SpConfirmDialog new
		  title: 'Important confirmation' localized;
		  label: aString;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #private }
SpScratchPresenter class >> libraryPaneHeight [
	^ self buttonHeight + 23
]

{ #category : #utilities }
SpScratchPresenter class >> longMessage: aString title: aString2 [

	UIManager default longMessage: aString title: aString2
]

{ #category : #utilities }
SpScratchPresenter class >> multiLineRequest: aString initialAnswer: aString2 [

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
SpScratchPresenter class >> multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2 [

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
SpScratchPresenter class >> request: aString [

	^ SpRequestDialog new
		  title: 'Information request' localized;
		  label: aString;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #utilities }
SpScratchPresenter class >> request: aString initialAnswer: aString2 [

	^ SpRequestDialog new
		  title: 'Information request' localized;
		  label: aString;
		  text: aString2;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #utilities }
SpScratchPresenter class >> select: aString chooseFrom: aCollection [

	^ SpSelectDialog new
		  title: aString;
		  items: aCollection;
			display: [ :each | each localized ];
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #private }
SpScratchPresenter class >> titleButtonHeight [
	^ 23 + 10
]

{ #category : #private }
SpScratchPresenter class >> viewerPaneWidth [
	^ 214
]

{ #category : #private }
SpScratchPresenter class >> workPaneHeight [
	^ 600
]

{ #category : #private }
SpScratchPresenter class >> workPaneWidth [
	^ 600
]

{ #category : #private }
SpScratchPresenter >> aboutTitle [
	^ application appName
]

{ #category : #'menu building' }
SpScratchPresenter >> addBlockMenu: aMenu for: aBlockMorph [
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
SpScratchPresenter >> addScriptMenu: aMenu for: aScript [

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
SpScratchPresenter >> alert: aString [

	self class alert: aString
]

{ #category : #'menu building' }
SpScratchPresenter >> blockMenuFor: aBlockMorph inScriptEditor: aBoolean [

	aBoolean ifFalse: [ ^ nil ].
	^ self newMenu in: [ :m | 
		  self addBlockMenu: m for: aBlockMorph.
		  m ]
]

{ #category : #utilities }
SpScratchPresenter >> chooseDirectory: aString [

	^ self class chooseDirectory: aString
]

{ #category : #utilities }
SpScratchPresenter >> chooseExistingFileReference: aString extensions: aCollection path: aFileReference [

	^ self class
		  chooseExistingFileReference: aString
		  extensions: aCollection
		  path: aFileReference
]

{ #category : #utilities }
SpScratchPresenter >> chooseExistingFileReference: aString extensions: aCollection path: aFileReference preview: aClass [

	^ self class
		  chooseExistingFileReference: aString
		  extensions: aCollection
		  path: aFileReference
		  preview: aClass
]

{ #category : #utilities }
SpScratchPresenter >> chooseForSaveFileReference: aString extensions: aCollection path: aFileReference [

	^ self class
		  chooseForSaveFileReference: aString
		  extensions: aCollection
		  path: aFileReference
]

{ #category : #utilities }
SpScratchPresenter >> confirm: aString [

	^ self class confirm: aString
]

{ #category : #accessing }
SpScratchPresenter >> currentCategory [

	^ viewerPane currentCategory
]

{ #category : #accessing }
SpScratchPresenter >> currentCategory: aString [
	viewerPane currentCategory: aString
]

{ #category : #private }
SpScratchPresenter >> defaultExtent [
	self subclassResponsibility
]

{ #category : #private }
SpScratchPresenter >> display [
	^ stageFrame display
]

{ #category : #'menu building' }
SpScratchPresenter >> examplesMenu [
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
SpScratchPresenter >> formFrom: aMorph extent: size [
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
SpScratchPresenter >> helpMenu [

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
SpScratchPresenter >> info: aString [
	self display info: aString
]

{ #category : #initialization }
SpScratchPresenter >> initializePresenters [

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
SpScratchPresenter >> initializeWindow: aWindow [
	aWindow
		initialExtent: self defaultExtent;
		aboutText: application class aboutAppString;
		whenClosedDo: [ application windowClosing ]
]

{ #category : #utilities }
SpScratchPresenter >> longMessage: aString title: aString2 [

	self class longMessage: aString title: aString2
]

{ #category : #accessing }
SpScratchPresenter >> modifiedText [

	^ modifiedProjectLabel label
]

{ #category : #accessing }
SpScratchPresenter >> modifiedText: aString [

	modifiedProjectLabel label: aString
]

{ #category : #utilities }
SpScratchPresenter >> multiLineRequest: aString initialAnswer: aString2 [

	^ self class multiLineRequest: aString initialAnswer: aString2
]

{ #category : #utilities }
SpScratchPresenter >> multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2 [

	^ self class multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2
]

{ #category : #initialization }
SpScratchPresenter >> newEditor [

	^ self newMorph
		  morph: self newEditorMorph;
		  yourself
]

{ #category : #initialization }
SpScratchPresenter >> newEditorMorph [

	^ ScrollFrameMorph new
		  growthFraction: 0.1;
		  color: ScratchTheme scriptsPaneColor;
		  yourself
]

{ #category : #initialization }
SpScratchPresenter >> newLogo [

	^ self newImage
		  image: (ScratchTheme formAt: #logo);
		  yourself
]

{ #category : #initialization }
SpScratchPresenter >> newStage [

	self subclassResponsibility
]

{ #category : #initialization }
SpScratchPresenter >> newViewer [

	^ self instantiate: SpScratchListViewer
]

{ #category : #private }
SpScratchPresenter >> privEditor [
	^ editorPane
]

{ #category : #private }
SpScratchPresenter >> privStage [
	^ stageFrame
]

{ #category : #accessing }
SpScratchPresenter >> projectName [

	^ projectNameLabel label
]

{ #category : #accessing }
SpScratchPresenter >> projectName: aString [

	projectNameLabel label: aString
]

{ #category : #utilities }
SpScratchPresenter >> request: aString [

	^ self class request: aString
]

{ #category : #utilities }
SpScratchPresenter >> request: aString initialAnswer: aString2 [

	^ self class request: aString initialAnswer: aString2
]

{ #category : #accessing }
SpScratchPresenter >> scriptForm [
	^ editorPane screenshot
]

{ #category : #'menu building' }
SpScratchPresenter >> scriptMenuFor: aScript [

	^ self newMenu in: [ :m | 
		  self addScriptMenu: m for: aScript.
		  m ]
]

{ #category : #utilities }
SpScratchPresenter >> select: aString chooseFrom: aCollection [

	^ self class select: aString chooseFrom: aCollection
]

{ #category : #accessing }
SpScratchPresenter >> settings [

	^ self application settings
]

{ #category : #'menu building' }
SpScratchPresenter >> settingsMenu [

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
SpScratchPresenter >> setupMenu [

	self subclassResponsibility
]

{ #category : #private }
SpScratchPresenter >> stageShotExtent: size [
	^ self formFrom: self display extent: size
]

{ #category : #stepping }
SpScratchPresenter >> stepTime [
	^ self display stepTime
]

{ #category : #stepping }
SpScratchPresenter >> stepTime: anInteger [
	self display
		stepTime: anInteger;
		startStepping
]

{ #category : #accessing }
SpScratchPresenter >> tab: aString [
	editorPane tab: aString
]

{ #category : #accessing }
SpScratchPresenter >> target [
	^ viewerPane target
]

{ #category : #accessing }
SpScratchPresenter >> target: aScript [
	viewerPane target: aScript.
	editorPane target: aScript
]

{ #category : #accessing }
SpScratchPresenter >> updateContents [
	viewerPane updateContents
]

{ #category : #accessing }
SpScratchPresenter >> updateDisplay [
	self display changed
]

{ #category : #private }
SpScratchPresenter >> updateWindowSettings [

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
SpScratchPresenter >> whenStepsDo: aBlock [
	self display
		whenStepsDo: aBlock;
		startStepping
]
