Class {
	#name : #SpSteloFrame,
	#superclass : #SpScratchFrame,
	#traits : 'TScratchPlotterMenu',
	#classTraits : 'TScratchPlotterMenu classTrait',
	#instVars : [
		'menuChangeWorld',
		'buttonOpen',
		'buttonSave',
		'logo',
		'menu'
	],
	#category : #'Stelo-Spec2'
}

{ #category : #TOREMOVE }
SpSteloFrame class >> buttonWidth [
	^ (ScratchTheme formAt: #saveButton) width + 10
]

{ #category : #specs }
SpSteloFrame class >> defaultSpec [
	^ SpBoxLayout newVertical
		add:
			(SpBoxLayout newHorizontal
				spacing: 4;
				add: #logo withConstraints: [ :c | c width: 200 ];
				add: #buttonOpen
					withConstraints: [ :c | c width: self buttonWidth ];
				add: #buttonSave
					withConstraints: [ :c | c width: self buttonWidth ];
				add: #menu;
				yourself)
			withConstraints: [ :c | c height: self toolbarHeight ];
		add:
			(SpBoxLayout newHorizontal
				add: #viewerPane
					withConstraints: [ :c | c width: self viewerPaneWidth ];
				add:
					(SpPanedLayout newHorizontal
						add: #editorPane;
						add:
							(SpBoxLayout newVertical
								add: #titlePane
									withConstraints: [ :c | c height: self titleButtonHeight ];
								add: #stageFrame;
								add: #libraryPane
									withConstraints: [ :c | c height: self libraryPaneHeight ];
								yourself);
						yourself);
				yourself);
		yourself
]

{ #category : #private }
SpSteloFrame class >> titleButtonHeight [
	^ 50
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
	self updateThumbnail
]

{ #category : #private }
SpSteloFrame >> currentBreedNo [
	^ self target breedNo
]

{ #category : #private }
SpSteloFrame >> dataMenu [
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Save Stage as PNG' localized;
						action: [ application saveStageAsImage ] ];
				addItem: [ :item | 
					item
						name: [ application isRecording
								ifTrue: [ 'Stop Stage Recording' localized ]
								ifFalse: [ 'Start Stage Recording' localized ] ];
						autoRefresh: true;
						action: [ application toggleStageRecording ] ] ];
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

{ #category : #private }
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
		yourself
]

{ #category : #private }
SpSteloFrame >> fileMenu [
	^ self newMenu
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'New' localized;
						action: [ application newProject.
							self plotter clearPlots ] ];
				addItem: [ :item | 
					item
						name: 'Open' localized;
						action: [ application openProject.
							self plotter clearPlots ] ];
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
						action: [ application saveProject ] ] ];
		addGroup: [ :grp | 
			grp
				addItem: [ :item | 
					item
						name: 'Import ...' localized;
						subMenu: self importMenu ];
				addItem: [ :item | 
					item
						name: 'Export ...' localized;
						subMenu: self exportMenu ] ];
		addItem: [ :item | 
			item
				name: 'Close' localized;
				action: [ application close ];
				enabled: [ application class dontClose not ] ];
		addItem: [ :item | 
			item
				name: 'Quit' localized;
				action: [ application quit ] ];
		yourself
]

{ #category : #private }
SpSteloFrame >> helpMenu [
	^ self newMenu
		addItem: [ :item | 
			item
				name: ('About ' , application appName)  localized;
				action: [ owner window showAbout ] ];
		addItem: [ :item | 
			item
				name: 'Restart' localized;
				action: [ stageFrame startStepping ] ];
		addItem: [ :item | 
			item
				name: 'Inspect' localized;
				action: [ application inspect ] ];
		addItem: [ :item | 
			menuChangeWorld := item.
			item
				name: 'Change world' localized;
				action: [ application toggleSWorld ];
				enabled: [ self isPluginAvailable ];
				autoRefresh: true ];
		addItem: [ :item | 
			item
				name: 'Settings' localized;
				subMenu: self settingsMenu ];
		yourself
]

{ #category : #private }
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
	logo := self newImage.
	buttonSave := self newButton.
	buttonOpen := self newButton.
	menu := self newMenuBar.
	viewerPane := self instantiate: SpScratchListViewer.
	editorPane := self instantiate: SpSteloEditor.
	titlePane := self instantiate: SpSteloTitle.
	stageFrame := self instantiate: SpSteloStage.
	libraryPane := self instantiate: SpSteloLibrary.
	self setupTopPane.
	self setupTitlePane.
	self focusOrder
		add: editorPane
]

{ #category : #private }
SpSteloFrame >> isPluginAvailable [
	[ SteloLibCall new getErrorMessage ] ifError: [ ^ false ].
	^ true
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
				subMenu: self helpMenu ].
	menu applyTo: self
]

{ #category : #'menu actions' }
SpSteloFrame >> showBreedNo: bno at: anInteger [
	| dialog |
	dialog := self instantiate: SpSteloBreedView.
	dialog
		title: self target objName , ' Variables';
		getValuesBlock: [ self sworld varsBreed: bno at: anInteger ];
		whenDeletedDo: [ self sworld kill: bno at: anInteger ].
	bno < SBreedId turtleBreedNo
		ifTrue: [ dialog openDialogWithSpec: #noDeleteButtonSpec ]
		ifFalse: [ dialog openDialogWithSpec ]
]

{ #category : #'menu actions' }
SpSteloFrame >> showBreedView: aPoint [
	| bno id |
	bno := self currentBreedNo.
	id := self sworld
		turtle: bno
		x: aPoint x
		y: aPoint y
		exceptBreed: 0
		index: 0.
	id = 0
		ifTrue: [ ^ self ].
	self showBreedNo: bno at: id
]

{ #category : #accessing }
SpSteloFrame >> status: aString [
	editorPane status: aString
]

{ #category : #accessing }
SpSteloFrame >> sworld [
	^ self display sworld
]

{ #category : #accessing }
SpSteloFrame >> sworld: aWorld [
	| display |
	display := self display.
	display
		sworld: aWorld;
		whenDoubleClickDo: [ :pos | self showBreedView: pos ]
		changed
]

{ #category : #accessing }
SpSteloFrame >> sworldMode: aSymbol [
	menuChangeWorld
		name:
			(aSymbol = #SMicroWorld
				ifTrue: [ 'Change to Pluginworld' localized ]
				ifFalse: [ 'Change to Microworld' localized ])
]

{ #category : #accessing }
SpSteloFrame >> target: anObject [
	super target: anObject.
	self updateThumbnail
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

{ #category : #private }
SpSteloFrame >> updateThumbnail [
	libraryPane thumbnail: (self stageShotExtent: self thumbnailExtent)
]

{ #category : #private }
SpSteloFrame >> updateTurtles [
	libraryPane turtles: application turtlesScripts.
	self display changed
]
