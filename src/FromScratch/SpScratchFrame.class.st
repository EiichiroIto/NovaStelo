Class {
	#name : #SpScratchFrame,
	#superclass : #SpPresenter,
	#instVars : [
		'viewerPane',
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
	SpScratchApp clipboard isString
		ifTrue: [ aMenu
				addItem: [ :item | 
					item
						name: 'paste' localized;
						action: [ application pasteBlock ] ] ].
	aMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'add sub block' localized;
						action: [ application addSubBlock: World cursorPoint script: aScript ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'clean up' localized;
						action: [ aScript cleanUp ] ] ]
]

{ #category : #'menu building' }
SpScratchFrame >> blockMenuFor: aBlockMorph inScriptEditor: aBoolean [
	| menu |
	aBoolean
		ifFalse: [ ^ nil ].
	menu := self newMenu.
	self addBlockMenu: menu for: aBlockMorph.
	^ menu
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
SpScratchFrame >> initializeWindow: aWindow [
	aWindow
		initialExtent: self defaultExtent;
		aboutText: application class aboutAppString;
		whenClosedDo: [ application windowClosing ]
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
	^ titlePane ifNotNil: [ titlePane projectName ]
]

{ #category : #accessing }
SpScratchFrame >> projectName: aString [
	titlePane ifNotNil: [ titlePane projectName: aString ]
]

{ #category : #accessing }
SpScratchFrame >> scriptForm [
	^ editorPane screenshot
]

{ #category : #'menu building' }
SpScratchFrame >> scriptMenuFor: aScript [
	| menu |
	menu := self newMenu.
	self addScriptMenu: menu for: aScript.
	^ menu
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
