Class {
	#name : #SpScratchApp,
	#superclass : #SpApplication,
	#instVars : [
		'presenter',
		'project',
		'projectDirectory'
	],
	#classVars : [
		'Clipboard',
		'Settings'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #accessing }
SpScratchApp class >> appFolderName [
	self subclassResponsibility
]

{ #category : #accessing }
SpScratchApp class >> appName [
	self subclassResponsibility
]

{ #category : #accessing }
SpScratchApp class >> clipboard [
	^ Clipboard
]

{ #category : #accessing }
SpScratchApp class >> clipboard: anObject [
	Clipboard := anObject
]

{ #category : #accessing }
SpScratchApp class >> deploySystem [
	"self deploySystem"
	(self confirm: 'Deploying System?')
		ifFalse: [ ^ self ].
	World closeAllWindowsDiscardingChanges.
	FreeTypeFontProvider current updateFromSystem.
	MCRepositoryGroup
		allSubInstancesDo: [ :gr | gr repositories do: [ :r | gr removeRepository: r ] ].
	IceRepository registry removeAll.
	IceCredentialStore current
		in:
			[ :store | store allCredentials do: [ :each | each removeFrom: store ] ].
	Smalltalk cleanUp: true except: {} confirming: false.
	Deprecation
		raiseWarning: false;
		showWarning: false.
	NoChangesLog install.
	NoPharoFilesOpener install.
	Stdio useNullStreams.
	MCCacheRepository uniqueInstance disable.
	EpMonitor reset.
	5 timesRepeat: [ Smalltalk garbageCollect ].
	Smalltalk snapshot: true andQuit: true
]

{ #category : #accessing }
SpScratchApp class >> dontClose [
	^ self settings at: #dontClose ifAbsentPut: [ false ]
]

{ #category : #accessing }
SpScratchApp class >> dontClose: aBoolean [
	self settings at: #dontClose put: aBoolean
]

{ #category : #accessing }
SpScratchApp class >> extension [
	self subclassResponsibility
]

{ #category : #private }
SpScratchApp class >> icon [
	^ (Form
	extent: (16@16)
	depth: 32
	fromArray: #( 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 20917024 0 0 2168865 0 0 0 218103844 14388762 0 0 0 0 0 0 0 150994979 2794676508 285212716 0 0 0 168429857 3619256603 654311460 0 0 0 0 0 0 0 0 3485892891 4292907545 2238268958 2847241755 2963893787 3467341852 4294944022 2156550166 0 2168865 0 0 0 0 0 0 2863230491 4294945048 4294680335 4294944270 4294944536 4294944534 4290743881 4154824329 1025776423 0 2168865 0 0 0 0 0 2897047835 4294418716 4290886326 4290558654 4293105701 4294944020 4291804323 4294967295 4287133026 201326592 0 0 0 0 0 493635615 4058486297 4293894182 4294439917 4292730080 4290616948 4294944786 4291332655 4291941340 4289702571 2188990254 0 0 0 237049889 1193351201 1601983006 4294221337 4294615059 4290091383 4292006100 4290820016 4292780356 4286797342 4289504157 4291282376 4292927458 1533501799 756945950 253827105 136386593 790698017 2640067871 4294484248 4294946610 4294634453 4293585643 4290492604 4294375674 4291874768 4294967295 4294967295 4294901502 4291019203 0 0 0 0 530080796 4209349913 4294948677 4294967295 4294046193 4294769916 4290821568 4291808719 4290887361 4293651179 4294967295 3649471110 688521226 86054945 0 0 0 1701200927 4293696546 4294965217 4294704639 4289900466 4293651179 4293651179 4289966259 4294835709 4140287175 609833561 0 0 0 0 4599584 0 1142559519 3569449230 3891254444 4126800119 4124299731 3939618769 3689605610 2643956631 167772160 0 0 0 0 0 0 2168865 0 83886119 356392448 597659520 614966441 427982466 134217728 0 0 2168865 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0 0)
	offset: (0@0))
]

{ #category : #'class initialization' }
SpScratchApp class >> initialize [
	Clipboard := nil.
	Settings := nil
]

{ #category : #accessing }
SpScratchApp class >> keepMaximize [
	^ self settings at: #keepMaximize ifAbsentPut: [ false ]
]

{ #category : #accessing }
SpScratchApp class >> keepMaximize: aBoolean [
	self settings at: #keepMaximize put: aBoolean
]

{ #category : #accessing }
SpScratchApp class >> language [
	^ self settings at: #language ifAbsent: [ '' ]
]

{ #category : #accessing }
SpScratchApp class >> language: aString [
	| old |
	old := self language.
	(ScratchTranslator setLocale: aString)
		ifFalse: [ ^ self ].
	self settings at: #language put: aString.
	old = aString
		ifTrue: [ ^ self ].
	(self confirm: 'Language settings has changed. Restart application?')
		ifFalse: [ ^ self ].
	self saveSettings.
	Smalltalk snapshot: false andQuit: true
]

{ #category : #accessing }
SpScratchApp class >> loadSettings [
	| fr dict |
	fr := FileSystem workingDirectory / self settingsFilename.
	fr isFile
		ifFalse: [ ^ self ].
	dict := STON fromString: fr contents.
	dict isDictionary
		ifFalse: [ ^ self ].
	dict keys
		do: [ :each | 
			(self respondsTo: each asSymbol)
				ifFalse: [ dict removeKey: each ] ].
	Settings := dict
]

{ #category : #accessing }
SpScratchApp class >> optionsFor: aSymbol [
	aSymbol = #stickyWindow
		ifTrue: [ ^ {true . false} ].
	aSymbol = #useErrorCatcher
		ifTrue: [ ^ {true . false} ].
	aSymbol = #dontClose
		ifTrue: [ ^ {true . false} ].
	aSymbol = #keepMaximize
		ifTrue: [ ^ {true . false} ].
	aSymbol = #language
		ifTrue: [ ^ ScratchTranslator availableLocales ].
	aSymbol = #projectDir
		ifTrue: [ ^ #string ].
	^ #()
]

{ #category : #accessing }
SpScratchApp class >> projectDir [
	| file dict |
	file := self settings
		at: #projectDir
		ifAbsent: [ ^ FileSystem workingDirectory pathString ].
	dict := Dictionary new.
	dict at: #documents put: FileLocator documents pathString.
	file := (file trimBoth format: dict) asFileReference.
	file isDirectory
		ifFalse: [ [ file createDirectory ]
				ifError: [ file := FileSystem workingDirectory ] ].
	^ file pathString
]

{ #category : #accessing }
SpScratchApp class >> projectDir: aString [
	self settings at: #projectDir put: aString
]

{ #category : #accessing }
SpScratchApp class >> saveSettings [
	| fr stream |
	fr := FileSystem workingDirectory / self settingsFilename.
	fr isFile
		ifTrue: [ fr delete ].
	stream := fr writeStream.
	STON put: self settings onStream: stream.
	stream close
]

{ #category : #accessing }
SpScratchApp class >> settingKeys [
	^ self settings keys sorted
]

{ #category : #accessing }
SpScratchApp class >> settingValueFor: aSymbol [
	^ self perform: aSymbol
]

{ #category : #private }
SpScratchApp class >> settings [
	^ Settings ifNil: [ Settings := Dictionary new ]
]

{ #category : #private }
SpScratchApp class >> settingsFilename [
	^ 'settings.ston'
]

{ #category : #accessing }
SpScratchApp class >> stickyWindow [
	^ self settings at: #stickyWindow ifAbsent: [ false ]
]

{ #category : #accessing }
SpScratchApp class >> stickyWindow: aBoolean [
	self settings at: #stickyWindow put: aBoolean
]

{ #category : #private }
SpScratchApp class >> thumbnailExtent [
	^ 120 @ 120
]

{ #category : #accessing }
SpScratchApp class >> try: aBlock onFailure: anErrorBlock [
	^ self useErrorCatcher
		ifTrue: [ aBlock ifError: anErrorBlock ]
		ifFalse: [ aBlock value ]
]

{ #category : #accessing }
SpScratchApp class >> useErrorCatcher [
	^ self settings at: #useErrorCatcher ifAbsent: [ false ]
]

{ #category : #accessing }
SpScratchApp class >> useErrorCatcher: aBoolean [
	self settings at: #useErrorCatcher put: aBoolean
]

{ #category : #private }
SpScratchApp >> aboutAppString [
	self subclassResponsibility
]

{ #category : #'button actions' }
SpScratchApp >> addList: aScript [
	| listName |
	listName := UIManager default request: 'List name?' localized.
	(listName isNil or: [ listName isEmpty ])
		ifTrue: [ ^ self ].
	(aScript variableNameInUse: listName)
		ifTrue: [ ^ UIManager default
				alert: 'That list name is already in use!' localized ].
	aScript addList: listName.
	presenter currentCategory: #variables
]

{ #category : #'menu actions' }
SpScratchApp >> addSubBlock: aPoint script: aScript [
	| subName |
	subName := UIManager default request: 'Sub name?' localized.
	(subName isNil or: [ subName isEmpty ])
		ifTrue: [ ^ self ].
	(aScript isValidSubName: subName)
		ifFalse: [ ^ UIManager default
				alert: 'invalid sub name!' localized ].
	(aScript subNameInUse: subName)
		ifTrue: [ ^ UIManager default
				alert: 'That sub name is already in use!' localized ].
	aScript addSubBlock: aPoint name: subName
]

{ #category : #'button actions' }
SpScratchApp >> addVariable: aScript [
	| varName |
	varName := UIManager default request: 'Variable name?' localized.
	(varName isNil or: [ varName isEmpty ])
		ifTrue: [ ^ self ].
	(aScript variableNameInUse: varName)
		ifTrue: [ ^ UIManager default
				alert: 'That variable name is already in use!' localized ].
	aScript addVariable: varName.
	presenter currentCategory: #variables
]

{ #category : #accessing }
SpScratchApp >> appFolderName [
	^ self class appFolderName
]

{ #category : #accessing }
SpScratchApp >> appName [
	^ self class appName
]

{ #category : #private }
SpScratchApp >> backupProject [
	self subclassResponsibility
]

{ #category : #private }
SpScratchApp >> basedVersion [
	^ '1.4 (source code of 23-Sep-09)'
]

{ #category : #private }
SpScratchApp >> closeMediaEditorsAndDialogs [
	SpDialogWindow allInstances do: #cancel.
	DialogWindow allInstances do: #cancel
]

{ #category : #'menu actions' }
SpScratchApp >> confirmForNewProject [
	| response |
	self closeMediaEditorsAndDialogs.
	self stopAllProcesses.
	(project notNil and: [ project modified ])
		ifTrue: [ response := UIManager default
				confirm: 'Save the current project?' localized
				orCancel: [ ^ false ].
			response
				ifTrue: [ ^ self saveProjectNoDialog ] ].
	^ true
]

{ #category : #'menu actions' }
SpScratchApp >> copyBlock: aBlockMorph [
	| code |
	code := self serializeBlocks: aBlockMorph.
	self class clipboard: code
]

{ #category : #private }
SpScratchApp >> createProject [
	self subclassResponsibility
]

{ #category : #'menu actions' }
SpScratchApp >> cutBlock: aBlockMorph [
	self copyBlock: aBlockMorph.
	aBlockMorph delete
]

{ #category : #'button actions' }
SpScratchApp >> deleteList: aScript [
	"Ask the user which user variable to delete, then remove it."

	| list choice |
	list := aScript listVarNames.
	list isEmpty
		ifTrue: [ ^ UIManager default alert: 'No lists.' localized ].
	choice := MenuMorph chooseFrom: list lines: #() title: ''.
	choice = 0
		ifTrue: [ ^ self ].
	aScript deleteList: (list at: choice).
	presenter currentCategory: #variables
]

{ #category : #'button actions' }
SpScratchApp >> deleteVariable: aScript [
	"Ask the user which user variable to delete, then remove it."

	| menu choice |
	aScript varNames isEmpty
		ifTrue: [ ^ UIManager default alert: 'No variables.' localized ].
	menu := MenuMorph new.
	menu target: [ :v | choice := v ].
	aScript varNames
		do: [ :v | menu add: v selector: #value: argument: v ].
	menu invokeModal: true.
	choice ifNil: [ ^ self ].
	aScript deleteVariable: choice.
	presenter currentCategory: #variables
]

{ #category : #private }
SpScratchApp >> deserializeFrom: aString [
	| lex list obj |
	lex := SexpLexer new read: aString.
	list := SexpParser new parse: lex.
	obj := (ScratchSexpImporter appName: self appName)
		importCode: list
		into: self target.
	obj ifNil: [ ^ nil ].
	obj position: ActiveHand position.
	^ obj
]

{ #category : #'change reporting' }
SpScratchApp >> displayExtentChanged [
	self class keepMaximize
		ifFalse: [ ^ self ].
	presenter window window fullscreen
]

{ #category : #'menu actions' }
SpScratchApp >> duplicateBlock: aBlockMorph [
	| code obj |
	code := self serializeBlocks: aBlockMorph.
	obj := self deserializeFrom: code.
	obj ifNil: [ ^ self ].
	ActiveHand grabMorph: obj
]

{ #category : #'menu actions' }
SpScratchApp >> editNotes [
	| ret |
	ret := UIManager default
		multiLineRequest: 'Project Notes' localized
		initialAnswer: project comment
		answerHeight: 450.
	ret ifNil: [ ^ self ].
	project comment: ret
]

{ #category : #private }
SpScratchApp >> exampleFiles [
	| list |
	list := self examplesDirectory filesMatching: '*.' , self class extension.
	^ list sorted
]

{ #category : #private }
SpScratchApp >> examplesDirectory [
	^ FileSystem workingDirectory / 'Examples'
]

{ #category : #private }
SpScratchApp >> export: anExporter extension: aString [
	self export: anExporter extension: aString isBinary: false
]

{ #category : #private }
SpScratchApp >> export: anExporter extension: aString isBinary: aBoolean [
	| str |
	str := self class
		try: [ anExporter exportFrom: self isBinary: aBoolean ]
		onFailure: [ :err | 
			UIManager default
				alert: 'Could not generate code: ' localized , err asString
				title: 'Export failed' localized ].
	self exportString: str extension: aString isBinary: aBoolean
]

{ #category : #private }
SpScratchApp >> exportString: aContentsString extension: aString isBinary: aBoolean [
	| file f |
	self closeMediaEditorsAndDialogs.
	self stopAllProcesses.
	file := UIManager default
		chooseForSaveFileReference: 'Export ...' localized
		extensions: {aString}
		path: self projectPath.
	file ifNil: [ ^ self ].
	f := nil.
	self class
		try: [ f := aBoolean
				ifTrue: [ file binaryWriteStream ]
				ifFalse: [ file writeStream ].
			f nextPutAll: aContentsString.
			f close ]
		onFailure: [ f ifNotNil: [ f close ].
			UIManager default
				alert: 'Could not write file: ' localized , file basename
				title: 'Export failed' localized ]
]

{ #category : #private }
SpScratchApp >> extension [
	^ self class extension
]

{ #category : #accessing }
SpScratchApp >> fixUnsavedFields [
	project ifNotNil: #fixUnsavedFields
]

{ #category : #private }
SpScratchApp >> import: anImporter extension: aString [
	self import: anImporter extension: aString isBinary: false
]

{ #category : #private }
SpScratchApp >> import: anImporter extension: aString isBinary: aBoolean [
	| code |
	code := self importFileWithExtension: aString isBinary: aBoolean.
	code ifNil: [ ^ self ].
	anImporter import: code first to: self.
	self restoreProject.
	presenter updateDisplay
]

{ #category : #private }
SpScratchApp >> importFileWithExtension: aString isBinary: aBoolean [
	| file f code |
	self closeMediaEditorsAndDialogs.
	self stopAllProcesses.
	file := UIManager default
		chooseExistingFileReference: 'Import ...' localized
		extensions: {aString}
		path: self projectDirectory.
	file ifNil: [ ^ nil ].
	file isFile
		ifFalse: [ ^ nil ].
	f := aBoolean
		ifTrue: [ file binaryReadStream ]
		ifFalse: [ file readStream ].
	^ self class
		try: [ code := f contents.
			f close.
			{code.
			file} ]
		onFailure: [ f ifNotNil: [ f close ].
			UIManager default
				alert: 'Could not read file: ' localized , file basename
				title: 'Import failed' localized.
			nil ]
]

{ #category : #initialization }
SpScratchApp >> initialize [
	self class loadSettings.
	ScratchTranslator setLocale: self class language.
	super initialize.
	presenter := self newPresenter
]

{ #category : #private }
SpScratchApp >> installNewProject: aProject [
	self subclassResponsibility
]

{ #category : #processes }
SpScratchApp >> isProcessRunning [
	self subclassResponsibility
]

{ #category : #'menu actions' }
SpScratchApp >> loadExample: aFileReference [
	| newProj |
	newProj := self createProject readProjectFrom: aFileReference.
	newProj ifNil: [ ^ self ].
	self projectDirectory: nil.
	self projectName: aFileReference base.
	self installNewProject: newProj
]

{ #category : #processes }
SpScratchApp >> newCode [
	self subclassResponsibility
]

{ #category : #private }
SpScratchApp >> newPresenter [
	self subclassResponsibility
]

{ #category : #'menu actions' }
SpScratchApp >> newProject [
	self confirmForNewProject
		ifFalse: [ ^ self ].
	self projectDirectory: nil.
	self projectName: 'New Project'.
	self installNewProject: self createProject
]

{ #category : #accessing }
SpScratchApp >> open [
	self open: presenter.
	self newProject.
	presenter window maximize.
	^ self
]

{ #category : #'menu actions' }
SpScratchApp >> openProject [
	| file newProj |
	self confirmForNewProject
		ifFalse: [ ^ self ].
	file := UIManager default
		chooseExistingFileReference: 'Open Project' localized
		extensions: {self class extension}
		path: self projectDirectory.
	file ifNil: [ ^ self ].
	newProj := self createProject readProjectFrom: file.
	newProj ifNil: [ ^ self ].
	self projectDirectory: file parent.
	self projectName: file base.
	self installNewProject: newProj
]

{ #category : #'menu actions' }
SpScratchApp >> pasteBlock [
	| code |
	code := self class clipboard.
	code ifNil: [ ^ self ].
	code isString ifFalse: [ ^ self ].
	self deserializeFrom: code
]

{ #category : #accessing }
SpScratchApp >> project [
	^ project
]

{ #category : #accessing }
SpScratchApp >> projectDirectory [
	^ projectDirectory
		ifNil: [ projectDirectory := self class projectDir asFileReference ]
]

{ #category : #accessing }
SpScratchApp >> projectDirectory: aFileReference [
	projectDirectory := aFileReference
]

{ #category : #testing }
SpScratchApp >> projectIsEmpty [
	^ true
]

{ #category : #private }
SpScratchApp >> projectName [
	^ presenter projectName
]

{ #category : #private }
SpScratchApp >> projectName: aString [
	| text |
	presenter projectName: aString.
	text := (aString isEmpty
		ifTrue: [ '' ]
		ifFalse: [ aString , '- ' ]) , self appName.
	presenter window
		title: text;
		updateTitle
]

{ #category : #accessing }
SpScratchApp >> projectPath [
	^ self projectDirectory / self projectName
]

{ #category : #'menu actions' }
SpScratchApp >> quit [
	(self confirm: 'Quit Application?' localized)
		ifFalse: [ ^ self ].
	Smalltalk snapshot: false andQuit: true
]

{ #category : #private }
SpScratchApp >> restoreProject [
	self subclassResponsibility
]

{ #category : #'menu actions' }
SpScratchApp >> saveProject [
	| file |
	self closeMediaEditorsAndDialogs.
	self stopAllProcesses.
	file := self saveScratchFileFor: project.
	file ifNil: [ ^ false ].
	^ self saveProjectAs: file
]

{ #category : #private }
SpScratchApp >> saveProjectAs: aFileReference [
	| targetName |
	targetName := presenter target objName.
	project
		thumbnailForm: (presenter stageShotExtent: self class thumbnailExtent).
	(project writeProjectAs: aFileReference)
		ifFalse: [ ^ false ].
	self projectName: aFileReference base.
	self projectDirectory: aFileReference parent.
	presenter target: (project findObjName: targetName).
	^ true
]

{ #category : #'menu actions' }
SpScratchApp >> saveProjectNoDialog [
	| file |
	self closeMediaEditorsAndDialogs.
	self stopAllProcesses.
	projectDirectory ifNil: [ ^ self saveProject ].
	file := self projectPath withExtension: self class extension.
	^ self saveProjectAs: file
]

{ #category : #private }
SpScratchApp >> saveScratchFileFor: aProject [
	^ UIManager default
		chooseForSaveFileReference: 'Save Project' localized
		extensions: {self class extension}
		path: self projectPath
]

{ #category : #'menu actions' }
SpScratchApp >> saveScriptsToImage [
	"Take a snapshot of all scripts for a sprite and save as a GIF file"

	| file saveForm |
	saveForm := presenter scriptForm.
	saveForm ifNil: [ ^ self ].
	file := UIManager default
		chooseForSaveFileReference: 'Save script snapshot' localized
		extensions: {'png'}
		path: self projectPath.
	file ifNil: [ ^ self ].
	saveForm writePNGFileNamed: file pathString
]

{ #category : #private }
SpScratchApp >> serializeBlocks: aTopBlock [
	| code |
	code := ScratchSexpGenerator new parse: aTopBlock initialIndent: 1.
	aTopBlock isHatBlock
		ifFalse: [ code := '(' , code , ')' ].
	^ code
]

{ #category : #private }
SpScratchApp >> setupView [
	| viewTarget |
	viewTarget := project scripts first.
	project scripts
		do: [ :m | 
			m hatBlocks size > viewTarget hatBlocks size
				ifTrue: [ viewTarget := m ] ].
	presenter target: viewTarget
]

{ #category : #'menu actions' }
SpScratchApp >> showBlockMenu: aBlockMorph event: anEvent [
	| menu |
	menu := presenter
		blockMenuFor: aBlockMorph
		inScriptEditor: aBlockMorph isInScriptEditor.
	menu ifNil: [ ^ self ].
	menu openWithSpecAt: anEvent cursorPoint
]

{ #category : #'menu actions' }
SpScratchApp >> showScriptMenu: aScript event: anEvent [
	(presenter scriptMenuFor: aScript)
		openWithSpecAt: anEvent cursorPoint
]

{ #category : #processes }
SpScratchApp >> startProcessFor: topBlock [
	self subclassResponsibility
]

{ #category : #processes }
SpScratchApp >> stepProcesses [
	self subclassResponsibility
]

{ #category : #processes }
SpScratchApp >> stopAllProcesses [
	self subclassResponsibility
]

{ #category : #accessing }
SpScratchApp >> target [
	^ presenter target
]

{ #category : #accessing }
SpScratchApp >> updateContents [
	presenter updateContents
]

{ #category : #private }
SpScratchApp >> windowClosing [
	"do nothing"
]
