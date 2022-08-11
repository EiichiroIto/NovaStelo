Class {
	#name : #SpSteloFrame,
	#superclass : #SpScratchFrame,
	#traits : 'TScratchPlotterMenu',
	#classTraits : 'TScratchPlotterMenu classTrait',
	#instVars : [
		'buttonOpen',
		'buttonSave',
		'logo',
		'menu',
		'inspectorPane',
		'inspectorTarget',
		'libraryPane'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #TOREMOVE }
SpSteloFrame class >> buttonWidth [
	^ (ScratchTheme formAt: #saveButton) width + 10
]

{ #category : #layout }
SpSteloFrame class >> defaultLayout [

	^ SpBoxLayout newVertical
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: #logo withConstraints: [ :c | c width: 200 ];
				   add: #buttonOpen
				   withConstraints: [ :c | c width: self buttonWidth ];
				   add: #buttonSave
				   withConstraints: [ :c | c width: self buttonWidth ];
				   add: #menu;
				   yourself)
		  withConstraints: [ :c | c height: self toolbarHeight ];
		  add: (SpBoxLayout newHorizontal
				   spacing: 4;
				   add: #viewerPane
				   withConstraints: [ :c | c width: self viewerPaneWidth ];
				   add: (SpPanedLayout newHorizontal
						    add: (SpPanedLayout newVertical
								     positionOfSlider: 20 percent;
								     add: #inspectorPane;
								     add: #editorPane;
								     yourself);
						    add: (SpBoxLayout newVertical
								     add: #titlePane withConstraints: [ :c | c expand: false ] ;
								     add: #stageFrame;
								     add: #libraryPane
								     withConstraints: [ :c | c height: self libraryPaneHeight ];
								     yourself);
						    yourself);
				   yourself);
		  yourself
]

{ #category : #private }
SpSteloFrame >> addBlockMenu: aMenu for: aBlockMorph [
	super addBlockMenu: aMenu for: aBlockMorph.
	aMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'bytecode' localized;
						action: [ application showBytecode: aBlockMorph ] ] ]
]

{ #category : #accessing }
SpSteloFrame >> addPlots: aCollection [
	editorPane addPlots: aCollection
]

{ #category : #private }
SpSteloFrame >> addTurtles [
	self
		target: application addTurtles;
		updateTurtles
]

{ #category : #inspecting }
SpSteloFrame >> changeColor: vno breed: bno at: id [

	| dialog cno |
	dialog := self instantiate: SpColorList.
	dialog openModal cancelled ifTrue: [ ^ self ].
	cno := dialog selectedColor.
	application sworld
		var: vno
		breed: bno
		at: id
		put: cno.
	self updateDisplay
]

{ #category : #inspecting }
SpSteloFrame >> changeNumberVar: vno breed: bno at: id [

	| val ret |
	val := application sworld var: vno breed: bno at: id.
	ret := application
		       request: 'Enter number' localized
		       initialAnswer: val asString.
	ret ifNil: [ ^ self ].
	application sworld
		var: vno
		breed: bno
		at: id
		put: ret asNumberNoError
]

{ #category : #inspecting }
SpSteloFrame >> changeValue: anArray [
	| var vno bno id |
	inspectorTarget = 0
		ifTrue: [ ^ self findObject: '' ].
	anArray ifNil: [ ^ self ].
	bno := self currentBreedNo.
	id := inspectorTarget.
	var := anArray first.
	var = 'id'
		ifTrue: [ ^ self findObject: id ].
	vno := self application project varNoFor: var breed: bno.
	(var = 'color' and: [ stageFrame morph isGrayscale not ])
		ifTrue: [ self changeColor: vno breed: bno at: id ]
		ifFalse: [ self changeNumberVar: vno breed: bno at: id ].
	self updateInspector
]

{ #category : #inspecting }
SpSteloFrame >> clearInspector [
	inspectorTarget := 0.
	inspectorPane
		items: #();
		selectedIndex: 0
]

{ #category : #initialization }
SpSteloFrame >> connectPresenters [
	buttonSave action: [ application saveProjectNoDialog ].
	buttonOpen action: [ application openProject ].
	libraryPane
		observerAction: [ self observerSelected ];
		patchesAction: [ self patchesSelected ];
		whenTurtlesSelectedDo: [ :bno | self turtlesSelected: bno ];
		whenTurtlesAddedDo: [ self addTurtles ];
		whenTurtlesDeletedDo: [ :bno | self turtlesDeleted: bno ].
	editorPane
		whenPlotterClicked: [ :plotter :event | self showMenuForPlotter: plotter event: event ].
	self updateThumbnail.
	stageFrame morph whenClickDo: [ :pos | self showBreedView: pos ].
	inspectorPane
		whenEditDo: [ :obj | self changeValue: obj ];
		whenDeleteDo: [ self deleteObject ]
]

{ #category : #private }
SpSteloFrame >> currentBreedNo [
	^ self target breedNo
]

{ #category : #'menu building' }
SpSteloFrame >> dataMenu [

	^ self newMenu
		  addGroup: [ :grp | 
			  grp addItem: [ :item | 
					  item
						  name: (application isRecording
								   ifTrue: [ 'Stop Stage Recording' localized ]
								   ifFalse: [ 'Start Stage Recording' localized ]);
						  action: [ 
							  application toggleStageRecording.
							  item name: (application isRecording
										   ifTrue: [ 'Stop Stage Recording' localized ]
										   ifFalse: [ 'Start Stage Recording' localized ]) ] ] ];
		  addGroup: [ :grp | 
			  grp
				  addItem: [ :item | 
					  item
						  name: 'Plots Data to Observer List' localized;
						  action: [ application copyPlotsToList ] ];
				  addItem: [ :item | 
					  item
						  name: 'Observer List to Plots Data' localized;
						  action: [ application copyListToPlots ] ] ];
		  yourself
]

{ #category : #private }
SpSteloFrame >> defaultExtent [
	^ 1024 @ 768
]

{ #category : #inspecting }
SpSteloFrame >> deleteObject [
	inspectorTarget = 0 ifTrue: [ ^ self ].
	application sworld kill: self currentBreedNo at: inspectorTarget.
	self updateDisplay.
	self clearInspector
]

{ #category : #private }
SpSteloFrame >> display [
	^ stageFrame morph
]

{ #category : #accessing }
SpSteloFrame >> eventMenuFrom: aDictionary whenSelected: aBlock [
	| m list |
	m := self newMenu.
	list := aDictionary keys.
	list := list copyWithoutAll: #(#startup #setup #loop #single).
	list isEmpty
		ifTrue: [ ^ nil ].
	list sorted
		do: [ :each | 
			m
				addItem: [ :item | 
					item
						name: each;
						action: [ aBlock cull: (aDictionary at: each) ] ] ].
	^ m
]

{ #category : #'menu building' }
SpSteloFrame >> exportMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Export Scripts in S-EXP' localized;
				action: [ application exportSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Export Plots as CSV' localized;
				action: [ application exportPlots ] ];
		addItem: [ :item | 
			item
				name: 'Export Script image' localized;
				action: [ application saveScriptsToImage ] ];
		addItem: [ :item | 
			item
				name: 'Export Stage image' localized;
				action: [ application saveStageAsImage ] ];
		yourself
]

{ #category : #'menu building' }
SpSteloFrame >> fileMenu [

	| m |
	m := self newMenu.
	m
		addItem: [ :item | 
			item
				name: 'New' localized;
				action: [ 
					application newProject.
					self plotter clearPlots ] ];
		addItem: [ :item | 
			item
				name: 'Open' localized;
				action: [ 
					application openProject.
					self plotter clearPlots ] ].
	application examplesDirectory isDirectory ifTrue: [ 
		m addItem: [ :item | 
			item
				name: 'Examples' localized;
				subMenu: self examplesMenu ] ].
	m addGroup: [ :grp | 
		grp
			addItem: [ :item | 
				item
					name: 'Project Notes' localized;
					action: [ application editNotes ] ];
			addItem: [ :item | 
				item
					name: 'Save' localized;
					action: [ application saveProjectNoDialog ] ];
			addItem: [ :item | 
				item
					name: 'Save As' localized;
					action: [ application saveProject ] ] ].
	m addGroup: [ :grp | 
		grp
			addItem: [ :item | 
				item
					name: 'Import ...' localized;
					subMenu: self importMenu ];
			addItem: [ :item | 
				item
					name: 'Export ...' localized;
					subMenu: self exportMenu ] ].
	m addGroup: [ :grp | 
		grp
			addItem: [ :item | 
				item
					name: 'Close' localized;
					action: [ application closeAllWindows ];
					enabled: [ self settings dontClose not ] ];
			addItem: [ :item | 
				item
					name: 'Quit' localized;
					action: [ application quit ] ] ].
	^ m
]

{ #category : #inspecting }
SpSteloFrame >> findObject: aString [

	| bno ret id |
	bno := self currentBreedNo.
	bno = SBreedId observerBreedNo ifTrue: [ ^ self ].
	ret := application
		       request: 'Enter id' localized
		       initialAnswer: aString asString.
	ret ifNil: [ ^ self ].
	id := ret asNumberNoError.
	(application sworld aliveBreed: bno at: id) ifFalse: [ 
		^ self clearInspector ].
	inspectorTarget := id.
	self updateInspector
]

{ #category : #'menu building' }
SpSteloFrame >> helpMenu [

	| checked unchecked m |
	checked := Smalltalk ui iconNamed: #smallOk.
	unchecked := Smalltalk ui iconNamed: #blank.
	m := self newMenu.
	m
		addItem: [ :item | 
			item
				name: ('About ' , application appName) localized;
				action: [ owner window showAbout ] ];
		addItem: [ :item | 
			item
				name: 'Restart' localized;
				action: [ stageFrame morph startStepping ] ];
		addItem: [ :item | 
			item
				name: 'Inspect' localized;
				enabled: [ self settings hideDebugMenu not ];
				action: [ application inspect ] ];
		addItem: [ :item | 
			item
				name: 'Settings' localized;
				enabled: [ self settings hideDebugMenu not ];
				subMenu: self settingsMenu ].
	m addGroup: [ :grp | 
		grp
			addItem: [ :item | 
				item
					name: 'Use Plugin Diffuser';
					icon: (application isPluginDiffuser
							 ifTrue: [ checked ]
							 ifFalse: [ unchecked ]);
					enabled: [ 
						SteloPlugin2 isAvailable and: [ application isPluginWorld not ] ];
					action: [ 
						application toggleDiffuser.
						item icon: (application isPluginDiffuser
									 ifTrue: [ checked ]
									 ifFalse: [ unchecked ]) ] ];
			addItem: [ :item | 
				item
					name: 'Use Plugin World';
					icon: (application isPluginWorld
							 ifTrue: [ checked ]
							 ifFalse: [ unchecked ]);
					enabled: [ self isPluginAvailable ];
					action: [ 
						application toggleSWorld.
						item icon: (application isPluginWorld
									 ifTrue: [ checked ]
									 ifFalse: [ unchecked ]) ] ];
			addItem: [ :item | 
				item
					name: 'Display in grayscale';
					icon: (stageFrame morph isGrayscale
							 ifTrue: [ checked ]
							 ifFalse: [ unchecked ]);
					action: [ 
						stageFrame morph toggleGrayscale.
						item icon: (stageFrame morph isGrayscale
									 ifTrue: [ checked ]
									 ifFalse: [ unchecked ]) ] ] ].
	^ m
]

{ #category : #'menu building' }
SpSteloFrame >> importMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: 'Import Scripts' localized;
				action: [ application importSexpCode ] ];
		addItem: [ :item | 
			item
				name: 'Import Plots' localized;
				action: [ application importPlots ] ];
		yourself
]

{ #category : #initialization }
SpSteloFrame >> initializePresenters [
	inspectorTarget := 0.
	logo := self newImage.
	buttonSave := self newButton.
	buttonOpen := self newButton.
	menu := self newMenuBar.
	viewerPane := self instantiate: SpScratchListViewer.
	inspectorPane := self instantiate: SpSteloInspector.
	editorPane := self instantiate: SpSteloEditor.
	titlePane := self instantiate: SpSteloTitle.
	stageFrame := self newMorph.
	stageFrame morph: SDisplay new.
	libraryPane := self instantiate: SpSteloLibrary.
	self setupTopPane.
	self setupTitlePane.
	self focusOrder
		add: editorPane
]

{ #category : #testing }
SpSteloFrame >> isPluginAvailable [
	[ SteloLibCall new getErrorMessage ] on: Error do: [ ^ false ].
	^ true
]

{ #category : #inspecting }
SpSteloFrame >> objectAt: aPoint [
	| bno pos |
	bno := self currentBreedNo.
	bno = SBreedId observerBreedNo
		ifTrue: [ ^ 1 ].
	pos := application project patches indexAtPoint: aPoint.
	bno = SBreedId patchBreedNo
		ifTrue: [ ^ pos ].
	^ application sworld
		turtle: bno
		at: pos
		exceptBreed: 0
		index: 0
]

{ #category : #private }
SpSteloFrame >> observerSelected [
	self target: application observerScript.
	self updateThumbnail
]

{ #category : #private }
SpSteloFrame >> patchesSelected [
	self target: application patchesScript
]

{ #category : #accessing }
SpSteloFrame >> plotter [
	^ editorPane plotter
]

{ #category : #initialization }
SpSteloFrame >> setupTitlePane [
	titlePane
		projectName: 'New Project';
		clearTurtlesAction: [ application clearTurtles ];
		clearPatchesAction: [ application clearPatches ];
		startSetupAction: [ application startSetup ];
		stopAllAction: [ application stopAll ];
		stepLoopAction: [ application stepLoop ];
		startLoopSlowAction: [ application startLoopSlow ];
		startLoopAction: [ application startLoop ];
		startEventAction: [ application startEvent ]
]

{ #category : #initialization }
SpSteloFrame >> setupTopPane [
	logo image: (ScratchTheme formAt: #scratchLogo).
	buttonOpen
		icon: (ScratchTheme formAt: #openButton);
		help: 'Open project'.
	buttonSave
		icon: (ScratchTheme formAt: #saveButton);
		help: 'Save this project'.
	menu
		addItem: [ :item | 
			item
				name: 'File' localized;
				subMenu: self fileMenu ];
		addItem: [ :item | 
			item
				name: 'Data' localized;
				subMenu: self dataMenu ];
		addItem: [ :item | 
			item
				name: 'Help' localized;
				subMenu: self helpMenu ]
]

{ #category : #inspecting }
SpSteloFrame >> showBreedView: aPoint [
	| id |
	id := aPoint ifNil: [ 0 ] ifNotNil: [ self objectAt: aPoint ].
	id = 0
		ifTrue: [ self clearInspector ]
		ifFalse: [ inspectorTarget := id.
			self updateInspector ]
]

{ #category : #accessing }
SpSteloFrame >> status: aString [
	editorPane status: aString
]

{ #category : #accessing }
SpSteloFrame >> sworld: aWorld [
	stageFrame morph
		sworld: aWorld;
		changed.
	self clearInspector
]

{ #category : #accessing }
SpSteloFrame >> target: anObject [
	super target: anObject.
	libraryPane selectButton: anObject objName.
	self updateThumbnail.
	self clearInspector
]

{ #category : #private }
SpSteloFrame >> thumbnailExtent [
	^ 40 @ 40
]

{ #category : #private }
SpSteloFrame >> turtlesDeleted: anInteger [
	application deleteTurtles: anInteger.
	self
		updateTurtles;
		target: application turtlesScripts first
]

{ #category : #private }
SpSteloFrame >> turtlesSelected: bno [
	self target: (application scriptOf: bno)
]

{ #category : #inspecting }
SpSteloFrame >> updateInspector [
	| list index |
	inspectorTarget = 0
		ifTrue: [ ^ self ].
	list := application varsAt: inspectorTarget.
	index := inspectorPane selectedIndex.
	index > list size
		ifTrue: [ index := 0 ].
	inspectorPane
		items: list;
		selectedIndex: index
]

{ #category : #private }
SpSteloFrame >> updateThumbnail [
	libraryPane thumbnail: (self stageShotExtent: self thumbnailExtent)
]

{ #category : #private }
SpSteloFrame >> updateTurtles [
	libraryPane turtles: application turtlesScripts.
	stageFrame morph changed
]
