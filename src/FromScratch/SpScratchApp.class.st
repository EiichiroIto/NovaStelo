Class {
	#name : #SpScratchApp,
	#superclass : #SpApplication,
	#instVars : [
		'presenter',
		'project',
		'projectDirectory',
		'settings',
		'extraDirectory'
	],
	#classVars : [
		'Clipboard',
		'UseErrorCatcher'
	],
	#category : #'FromScratch-Spec2'
}

{ #category : #constants }
SpScratchApp class >> aboutAppString [
	self subclassResponsibility
]

{ #category : #utilities }
SpScratchApp class >> alert: aString [

	SpInformDialog new
		title: 'alert!' localized;
		label: aString;
		acceptLabel: 'Close' localized;
		openModal
]

{ #category : #constants }
SpScratchApp class >> appFolderName [
	self subclassResponsibility
]

{ #category : #constants }
SpScratchApp class >> appName [
	self subclassResponsibility
]

{ #category : #constants }
SpScratchApp class >> basedVersion [
	^ '1.4 (source code of 23-Sep-09)'
]

{ #category : #accessing }
SpScratchApp class >> clipboard [
	^ Clipboard
]

{ #category : #accessing }
SpScratchApp class >> clipboard: anObject [
	Clipboard := anObject
]

{ #category : #utilities }
SpScratchApp class >> confirm: aString [

	^ SpConfirmDialog new
		  title: 'Important confirmation' localized;
		  label: aString;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
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

{ #category : #constants }
SpScratchApp class >> extension [
	self subclassResponsibility
]

{ #category : #constants }
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
	UseErrorCatcher := false
]

{ #category : #utilities }
SpScratchApp class >> multiLineRequest: aString initialAnswer: aString2 [

	^ SpRequestTextDialog new
		  title: 'Information request' localized;
		  label: aString;
		  text: aString2;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #utilities }
SpScratchApp class >> multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2 [

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

{ #category : #'instance creation' }
SpScratchApp class >> open [

	| settings |
	settings := self settingsClass new.
	settings loadFile:
		FileSystem workingDirectory / self settingsFilename.
	self openWithSettings: settings
]

{ #category : #'instance creation' }
SpScratchApp class >> openWithSettings: aSettings [

	ScratchTranslator setLocale: aSettings language.
	self new
		settings: aSettings;
		open
]

{ #category : #constants }
SpScratchApp class >> presentationClass [
	self subclassResponsibility
]

{ #category : #constants }
SpScratchApp class >> previewClass [
	"self projectClass if use preview"
	^ nil
]

{ #category : #constants }
SpScratchApp class >> projectClass [
	self subclassResponsibility
]

{ #category : #'menu actions' }
SpScratchApp class >> quit [

	(self confirm: 'Quit Application?' localized) ifFalse: [ ^ self ].
	Smalltalk snapshot: false andQuit: true
]

{ #category : #utilities }
SpScratchApp class >> request: aString [

	^ SpRequestDialog new
		  title: 'Information request' localized;
		  label: aString;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #utilities }
SpScratchApp class >> request: aString initialAnswer: aString2 [

	^ SpRequestDialog new
		  title: 'Information request' localized;
		  label: aString;
		  text: aString2;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #constants }
SpScratchApp class >> screenshotExtent [
	^ 400 @ 400
]

{ #category : #utilities }
SpScratchApp class >> select: aString chooseFrom: aCollection [

	^ SpSelectDialog new
		  title: aString;
		  items: aCollection;
			acceptLabel: 'OK' localized;
			cancelLabel: 'Cancel' localized;
		  openModal
]

{ #category : #constants }
SpScratchApp class >> settingsClass [
	^ ScratchSettings
]

{ #category : #constants }
SpScratchApp class >> settingsFilename [
	^ 'settings.ston'
]

{ #category : #constants }
SpScratchApp class >> thumbnailExtent [
	^ 120 @ 120
]

{ #category : #accessing }
SpScratchApp class >> try: aBlock onFailure: anErrorBlock [
	^ UseErrorCatcher
		ifTrue: [ aBlock
				on: Error
				do: anErrorBlock ]
		ifFalse: [ aBlock value ]
]

{ #category : #accessing }
SpScratchApp class >> useErrorCatcher: aBoolean [

	UseErrorCatcher := aBoolean
]

{ #category : #'button actions' }
SpScratchApp >> addList: aScript [

	| listName |
	listName := self request: 'List name?' localized.
	listName := self normalizeVariableName: listName.
	(listName isNil or: [ listName isEmpty ]) ifTrue: [ ^ self ].
	(aScript variableNameInUse: listName) ifTrue: [ 
		^ self alert: 'That list name is already in use!' localized ].
	aScript addList: listName.
	presenter currentCategory: #variables
]

{ #category : #'menu actions' }
SpScratchApp >> addSubBlock: aPoint script: aScript [

	| subName |
	subName := self request: 'Sub name?' localized.
	subName := self normalizeModuleName: subName.
	(subName isNil or: [ subName isEmpty ]) ifTrue: [ ^ self ].
	(aScript isValidSubName: subName) ifFalse: [ 
		^ self alert: 'invalid sub name!' localized ].
	(aScript subNameInUse: subName) ifTrue: [ 
		^ self alert: 'That sub name is already in use!' localized ].
	aScript addSubBlock: aPoint name: subName
]

{ #category : #'button actions' }
SpScratchApp >> addVariable: aScript [

	| varName |
	varName := self request: 'Variable name?' localized.
	varName := self normalizeVariableName: varName.
	(varName isNil or: [ varName isEmpty ]) ifTrue: [ ^ self ].
	(aScript variableNameInUse: varName) ifTrue: [ 
		^ self alert: 'That variable name is already in use!' localized ].
	aScript addVariable: varName.
	presenter currentCategory: #variables
]

{ #category : #utilities }
SpScratchApp >> alert: aString [

	self class alert: aString
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
SpScratchApp >> closeMediaEditorsAndDialogs [

	(self currentWorld submorphs select: [ :each | 
		 each isKindOf: DialogWindowMorph ]) do: #delete
]

{ #category : #utilities }
SpScratchApp >> confirm: aString [

	^ self class confirm: aString
]

{ #category : #'menu actions' }
SpScratchApp >> confirmForNewProject [

	| response |
	self closeMediaEditorsAndDialogs.
	self stopAllProcesses.
	(project notNil and: [ project modified ]) ifTrue: [ 
		response := self confirm: 'Save the current project?' localized.
		response ifTrue: [ ^ self saveProjectNoDialog ] ].
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
	^ self class projectClass new
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
	list isEmpty ifTrue: [ ^ self ].
	choice := self select: 'Choose list var to delete.' localized chooseFrom: list.
	choice ifNil: [ ^ self ].
	aScript deleteList: choice.
	presenter currentCategory: #variables
]

{ #category : #'button actions' }
SpScratchApp >> deleteVariable: aScript [
	"Ask the user which user variable to delete, then remove it."

	| list choice |
	list := aScript varNames.
	list isEmpty
		ifTrue: [ ^ self ].
	choice := self select: 'Choose variable to delete.' localized chooseFrom: list.
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
	obj position: World cursorPoint.
	^ obj
]

{ #category : #'change reporting' }
SpScratchApp >> displayExtentChanged [
	settings keepMaximize
		ifFalse: [ ^ self ].
	presenter window window fullscreen
]

{ #category : #'menu actions' }
SpScratchApp >> duplicateBlock: aBlockMorph [
	| code obj |
	code := self serializeBlocks: aBlockMorph.
	obj := self deserializeFrom: code.
	obj ifNil: [ ^ self ].
	aBlockMorph activeHand grabMorph: obj
]

{ #category : #'menu actions' }
SpScratchApp >> editNotes [

	| ret |
	self closeMediaEditorsAndDialogs.
	ret := self
		       multiLineRequest: 'Project Notes' localized
		       initialAnswer: project comment.
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

	self flag: #ToBeRemoved.
	self export: anExporter extension: aString isBinary: false
]

{ #category : #private }
SpScratchApp >> export: anExporter extension: aString isBinary: aBoolean [

	| str |
	str := self class
		       try: [ anExporter exportFrom: self isBinary: aBoolean ]
		       onFailure: [ :err | 
			       self alert:
				       'Could not generate code: ' localized , err asString ].
	self exportString: str extension: aString isBinary: aBoolean
]

{ #category : #'menu actions' }
SpScratchApp >> exportScriptImage [

	| file saveForm |
	saveForm := presenter scriptForm.
	saveForm ifNil: [ ^ self ].
	file := UIManager default
		        chooseForSaveFileReference: 'Export ...' localized
		        extensions: { self imageExtension }
		        path: self extraPath.
	file ifNil: [ ^ self ].
	self extraDirectory: file parent.
	saveForm writePNGFileNamed: file pathString
]

{ #category : #'menu actions' }
SpScratchApp >> exportStageImage [

	| file saveForm |
	saveForm := presenter stageShotExtent: self class screenshotExtent.
	saveForm ifNil: [ ^ self ].
	file := UIManager default
		        chooseForSaveFileReference: 'Export ...' localized
		        extensions: { self imageExtension }
		        path: self extraPath.
	file ifNil: [ ^ self ].
	self extraDirectory: file parent.
	saveForm writePNGFileNamed: file pathString
]

{ #category : #private }
SpScratchApp >> exportString: aContentsString extension: aString isBinary: aBoolean [

	| file f |
	self closeMediaEditorsAndDialogs.
	self stopAllProcesses.
	file := UIManager default
		        chooseForSaveFileReference: 'Export ...' localized
		        extensions: { aString }
		        path: self extraPath.
	file ifNil: [ ^ self ].
	self extraDirectory: file parent.
	f := nil.
	self class
		try: [ 
			f := aBoolean
				     ifTrue: [ file binaryWriteStream ]
				     ifFalse: [ file writeStream ].
			f nextPutAll: aContentsString.
			f close ]
		onFailure: [ 
			f ifNotNil: [ f close ].
			self alert: 'Could not write file: ' localized , file basename ]
]

{ #category : #private }
SpScratchApp >> extension [
	^ self class extension
]

{ #category : #accessing }
SpScratchApp >> extraDirectory [

	extraDirectory ifNotNil: [ ^ extraDirectory ].
	^ self projectDirectory
]

{ #category : #accessing }
SpScratchApp >> extraDirectory: anObject [

	extraDirectory := anObject
]

{ #category : #accessing }
SpScratchApp >> extraPath [
	^ self extraDirectory / self projectName
]

{ #category : #accessing }
SpScratchApp >> fixUnsavedFields [
	project ifNotNil: #fixUnsavedFields
]

{ #category : #private }
SpScratchApp >> imageExtension [
	^ 'png'
]

{ #category : #private }
SpScratchApp >> import: anImporter extension: aString [

	self flag: #ToBeRemoved.
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
		        extensions: { aString }
		        path: self extraDirectory.
	file ifNil: [ ^ nil ].
	file isFile ifFalse: [ ^ nil ].
	self extraDirectory: file parent.
	f := aBoolean
		     ifTrue: [ file binaryReadStream ]
		     ifFalse: [ file readStream ].
	^ self class
		  try: [ 
			  code := f contents.
			  f close.
			  { 
				  code.
				  file } ]
		  onFailure: [ 
			  f ifNotNil: [ f close ].
			  self alert: 'Could not read file: ' localized , file basename.
			  nil ]
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
	self confirmForNewProject ifFalse: [ ^ self ].
	newProj := self readProjectFrom: aFileReference.
	newProj ifNil: [ ^ self ].
	self projectDirectory: nil.
	self projectName: aFileReference base.
	self installNewProject: newProj
]

{ #category : #utilities }
SpScratchApp >> multiLineRequest: aString initialAnswer: aString2 [

	^ self class multiLineRequest: aString initialAnswer: aString2
]

{ #category : #utilities }
SpScratchApp >> multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2 [

	^ self class multiSelect: aString chooseFrom: aCollection selectedItems: aCollection2
]

{ #category : #processes }
SpScratchApp >> newCode [
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

{ #category : #private }
SpScratchApp >> normalizeModuleName: aString [

	^ aString
]

{ #category : #private }
SpScratchApp >> normalizeVariableName: aString [

	^ aString
]

{ #category : #accessing }
SpScratchApp >> open [

	| window |
	self prepareForOpening.
	presenter := self newPresenter: self class presentationClass.
	window := presenter open.
	self newProject. 
	presenter updateWindowSettings.
	window maximize.
	presenter whenStepsDo: [ self stepProcesses ].
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
		path: self projectDirectory
		preview: self class previewClass.
	file ifNil: [ ^ self ].
	file isFile ifFalse: [ ^ self ].
	newProj := self readProjectFrom: file.
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

{ #category : #private }
SpScratchApp >> prepareForOpening [
	"do nothing"
]

{ #category : #accessing }
SpScratchApp >> presenter [

	^ presenter
]

{ #category : #accessing }
SpScratchApp >> presenter: anObject [

	presenter := anObject
]

{ #category : #accessing }
SpScratchApp >> project [
	^ project
]

{ #category : #accessing }
SpScratchApp >> projectDirectory [

	| file dict |
	projectDirectory ifNotNil: [ ^ projectDirectory ].
	file := settings projectDir trimBoth.
	file isEmpty ifTrue: [ ^ FileSystem workingDirectory ].
	dict := Dictionary new.
	dict at: #documents put: FileLocator documents pathString.
	dict at: #app put: self appFolderName.
	file := (file format: dict) asFileReference.
	file isDirectory ifFalse: [ 
		[ file createDirectory ]
			on: Error
			do: [ file := FileSystem workingDirectory ] ].
	^ file
]

{ #category : #accessing }
SpScratchApp >> projectDirectory: aFileReference [
	projectDirectory := aFileReference
]

{ #category : #testing }
SpScratchApp >> projectIsEmpty [
	^ true
]

{ #category : #'change reporting' }
SpScratchApp >> projectModified [

	presenter ifNil: [ ^ self ].
	presenter modifiedText: (project modified
			 ifTrue: [ '[modified]' localized ]
			 ifFalse: [ '' ])
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

{ #category : #'file read/write' }
SpScratchApp >> readProjectFrom: aFileReference [

	| f projData newProj reader |
	reader := project newProjectReadWriter.
	f := aFileReference binaryReadStream.
	f ifNil: [ 
		self alert:
			'Could not read file: ' localized , aFileReference pathString.
		^ nil ].
	^ self class
		  try: [ 
			  projData := f contents.
			  newProj := reader extractProjectFrom: projData.
			  newProj info: (reader extractInfoFrom: projData).
			  newProj ]
		  onFailure: [ :err | 
			  self alert: err messageText.
			  nil ]
]

{ #category : #utilities }
SpScratchApp >> request: aString [

	^ self class request: aString
]

{ #category : #utilities }
SpScratchApp >> request: aString initialAnswer: aString2 [

	^ self class request: aString initialAnswer: aString2
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
	(self writeProjectAs: aFileReference)
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

{ #category : #settings }
SpScratchApp >> saveSettings [

	settings saveFile:
		FileSystem workingDirectory / self class settingsFilename
]

{ #category : #utilities }
SpScratchApp >> select: aString chooseFrom: aCollection [

	^ self class select: aString chooseFrom: aCollection
]

{ #category : #settings }
SpScratchApp >> selectSetting: aSymbol [

	| list ret old |
	self closeMediaEditorsAndDialogs.
	list := settings optionsFor: aSymbol.
	ret := list = #string
		       ifTrue: [ 
			       self
				       request: 'Enter for ' localized , aSymbol
				       initialAnswer: (self settingAt: aSymbol) ]
		       ifFalse: [ 
			       list isEmpty ifTrue: [ ^ self ].
			       self
				       select: 'Select an option for ' localized , aSymbol
				       chooseFrom: list ].
	ret ifNil: [ ^ self ].
	ret = (self settingAt: aSymbol) ifTrue: [ ^ self ].
	self settingAt: aSymbol put: ret.
	aSymbol = #language ifFalse: [ ^ self ].
	(self confirm: 'Language settings has changed. Restart application?') 
		ifFalse: [ ^ self ].
	old := self settingAt: #dontClose.
	self settingAt: #dontClose put: false.
	presenter updateWindowSettings.
	self closeAllWindows.
	self settingAt: #dontClose put: old.
	self class openWithSettings: settings
]

{ #category : #private }
SpScratchApp >> serializeBlocks: aTopBlock [
	| code |
	code := ScratchSexpGenerator new parse: aTopBlock initialIndent: 1.
	aTopBlock isHatBlock
		ifFalse: [ code := '(' , code , ')' ].
	^ code
]

{ #category : #settings }
SpScratchApp >> settingAt: aSymbol [

	^ settings at: aSymbol
]

{ #category : #settings }
SpScratchApp >> settingAt: aSymbol put: anObject [

	settings at: aSymbol put: anObject
]

{ #category : #settings }
SpScratchApp >> settingKeys [

	^ settings keys
]

{ #category : #accessing }
SpScratchApp >> settings [

	^ settings
]

{ #category : #accessing }
SpScratchApp >> settings: anObject [

	settings := anObject
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

{ #category : #'file read/write' }
SpScratchApp >> unusedNameStartingWith: prefix in: aFileReference [
	| usedNames i result |
	usedNames := (aFileReference entries
		collect: [ :each | each basename ]) asSet.
	i := 0.
	result := prefix , '0'.
	[ usedNames includes: result ]
		whileTrue: [ result := prefix , (i := i + 1) printString ].
	^ aFileReference / result
]

{ #category : #accessing }
SpScratchApp >> updateContents [
	presenter updateContents
]

{ #category : #private }
SpScratchApp >> windowClosing [
	"do nothing"
]

{ #category : #'file read/write' }
SpScratchApp >> writeProjectAs: aFileReference [

	| saveError out tmpFile writer |
	writer := project newProjectReadWriter.
	saveError := nil.
	tmpFile := (self
		            unusedNameStartingWith: 'tmp'
		            in: aFileReference parent) asFileReference.
	self class
		try: [ 
			out := tmpFile binaryWriteStream.
			out
				ifNil: [ 
				saveError := 'Folder may be locked or read-only' localized ]
				ifNotNil: [ 
					writer writeProject: project to: out.
					out close ] ]
		onFailure: [ :err | 
			out ifNotNil: [ 
				[ 
				out close.
				tmpFile delete ]
					on: Error
					do: [  ] ].
			saveError := err ].
	saveError ifNotNil: [ 
		self alert: saveError.
		^ false ].
	aFileReference deleteIfAbsent: [  ].
	[ tmpFile renameTo: aFileReference basename ]
		on: Error
		do: [ 
			self alert:
				'Save failed. The folder may be read-only.' localized.
			^ false ].
	project modified: false.
	^ true
]
