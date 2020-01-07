Class {
	#name : #SpScratchApp,
	#superclass : #SpApplication,
	#instVars : [
		'presenter',
		'project',
		'process',
		'updateInfoCount'
	],
	#classVars : [
		'Clipboard',
		'UseErrorCatcher'
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
	UseErrorCatcher := false.
	Clipboard := nil
]

{ #category : #accessing }
SpScratchApp class >> putInClipboard: anObject [
	Clipboard := anObject
]

{ #category : #private }
SpScratchApp class >> thumbnailExtent [
	^ 120 @ 120
]

{ #category : #accessing }
SpScratchApp class >> try: aBlock onFailure: anErrorBlock [
	self useErrorCatcher
		ifTrue: [ aBlock ifError: anErrorBlock ]
		ifFalse: aBlock value
]

{ #category : #accessing }
SpScratchApp class >> useErrorCatcher [
	^ UseErrorCatcher
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
				alert: 'That list name is already in use' localized ].
	aScript addList: listName.
	presenter currentCategory: #variables
]

{ #category : #'menu actions' }
SpScratchApp >> addSubBlock: anEvent script: aScript [
	| subName |
	subName := UIManager default request: 'Sub name?'.
	(subName isNil or: [ subName isEmpty ])
		ifTrue: [ ^ self ].
	aScript addSubBlock: anEvent cursorPoint name: subName
]

{ #category : #'button actions' }
SpScratchApp >> addVariable: aScript [
	| varName |
	varName := UIManager default request: 'Variable name?' localized.
	(varName isNil or: [ varName isEmpty ])
		ifTrue: [ ^ self ].
	(aScript variableNameInUse: varName)
		ifTrue: [ ^ UIManager default
				alert: 'That variable name is already in use' localized ].
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
SpScratchApp >> chooseExistingFileType: aSymbol title: aString extension: ext [
	| dialog d |
	dialog := SpFileChooserDialog new.
	dialog
		extension: ext;
		title: aString;
		type: aSymbol.
	d := dialog openModalWithSpec: #chooseExistingFileSpec.
	d isCancelled
		ifTrue: [ ^ nil ].
	^ dialog selectedFile
]

{ #category : #private }
SpScratchApp >> chooseNewFileDefault: filename extension: ext title: aString type: aSymbol [
	| dialog d |
	dialog := SpFileChooserDialog new.
	dialog
		extension: ext;
		filename: filename;
		title: aString;
		type: aSymbol.
	d := dialog openModalWithSpec: #chooseNewFileSpec.
	d isCancelled
		ifTrue: [ ^ nil ].
	^ dialog filename
]

{ #category : #private }
SpScratchApp >> closeMediaEditorsAndDialogs [
	SpDialogWindow allInstances do: #cancel.
	DialogWindow allInstances do: #cancel.
	^ true
]

{ #category : #private }
SpScratchApp >> confirmFileOverwriteIfExisting: aFileReference orCancel: aBlock [
	| file response |
	file := aFileReference withExtension: self extension.
	file isFile
		ifFalse: [ ^ file ].
	response := UIManager default
		confirm: 'The file name already exists. Overwrite existing file?' localized
		orCancel: aBlock.
	^ response
		ifTrue: [ file ]
		ifFalse: [ nil ]
]

{ #category : #private }
SpScratchApp >> createProject [
	self subclassResponsibility
]

{ #category : #accessing }
SpScratchApp >> currentTab [
	^ presenter currentTab
]

{ #category : #accessing }
SpScratchApp >> currentTarget [
	^ presenter currentTarget
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
SpScratchApp >> export: anExporter extension: aString [
	| fName f str |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	fName := self
		chooseNewFileDefault: self projectName
		extension: aString
		title: 'Export ...'
		type: #export.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: aString.
	fName isFile
		ifTrue: [ (UIManager default
				confirm: 'Overwrite existing ' , fName basename , '?')
				ifFalse: [ ^ self ].
			fName delete ].
	f := nil.
	self class
		try: [ f := fName writeStream.
			str := anExporter exportFrom: self.
			f nextPutAll: str.
			f close ]
		onFailure: [ f ifNotNil: [ f close ].
			UIManager default
				alert: 'Could not write file' , fName basename
				title: 'Export failed' localized ]
]

{ #category : #private }
SpScratchApp >> extension [
	^ self class extension
]

{ #category : #private }
SpScratchApp >> import: anImporter extension: aString [
	| response fr f code |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	response := self
		chooseExistingFileType: #export
		title: 'Import ...'
		extension: aString.
	response ifNil: [ ^ self ].
	fr := response asFileReference.
	fr isFile
		ifFalse: [ ^ self ].
	[ f := fr readStream.
	code := f contents.
	f close ]
		ifError: [ f ifNotNil: [ f close ].
			^ UIManager default
				alert: 'Could not read file' localized
				title: 'Import failed' localized ].
	anImporter import: code to: self.
	self restoreProject.
	presenter updateDisplay
]

{ #category : #initialization }
SpScratchApp >> initialize [
	super initialize.
	presenter := self newPresenter.
	updateInfoCount := 0
]

{ #category : #private }
SpScratchApp >> installNewProject: aProject [
	self subclassResponsibility
]

{ #category : #processes }
SpScratchApp >> isProcessRunning [
	^ process notNil and: [ process isRunning ]
]

{ #category : #processes }
SpScratchApp >> maxUpdateInfoCount [
	^ 50
]

{ #category : #private }
SpScratchApp >> newPresenter [
	self subclassResponsibility
]

{ #category : #'menu actions' }
SpScratchApp >> newProject [
	| response |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	(project notNil and: [ project modified ])
		ifTrue: [ response := UIManager default
				confirm: 'Save the current project?' localized
				orCancel: [ ^ self ].
			response
				ifTrue: [ self saveProjectNoDialog ] ].
	self
		projectDirectory: (ScratchDirectory current getDefaultFolderForType: #project).
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
	| response newProj |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	(project notNil and: [ project modified ])
		ifTrue: [ response := UIManager default
				confirm: 'Save the current project?'
				orCancel: [ ^ self ].
			response
				ifTrue: [ self saveProjectNoDialog ] ].
	response := self openScratchFileFor: self createProject.
	response ifNil: [ ^ self ].
	newProj := self createProject readProjectFrom: response.
	newProj ifNil: [ ^ self ].
	self projectDirectory: response parent.
	self projectName: response base.
	self installNewProject: newProj
]

{ #category : #private }
SpScratchApp >> openScratchFileFor: aProject [
	| dialog d |
	dialog := SpFileChooserDialog new.
	dialog
		extension: self extension;
		project: aProject;
		setupForFileInfoViewer;
		title: 'Open Project';
		type: #project.
	d := dialog openModalWithSpec: #openScratchFileSpec.
	d isCancelled
		ifTrue: [ ^ nil ].
	^ dialog selectedFile
]

{ #category : #accessing }
SpScratchApp >> project [
	^ project
]

{ #category : #private }
SpScratchApp >> projectDirectory [
	^ ScratchDirectory current getLastFolderForType: #project
]

{ #category : #private }
SpScratchApp >> projectDirectory: aFileReference [
	ScratchDirectory current
		setLastFolderTo: aFileReference
		forType: #project
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

{ #category : #private }
SpScratchApp >> restoreProject [
	self subclassResponsibility
]

{ #category : #'menu actions' }
SpScratchApp >> saveProject [
	| fName result |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	fName := self saveScratchFileFor: project.
	fName ifNil: [ ^ self ].
	[ (result := self
		confirmFileOverwriteIfExisting: fName
		orCancel: [ ^ self ]) isNil ]
		whileTrue: [ fName := self saveScratchFileFor: project.
			fName ifNil: [ ^ self ] ].
	project
		thumbnailForm: (presenter stageShotExtent: self class thumbnailExtent).
	(project writeProjectAs: result)
		ifFalse: [ ^ self ].
	self projectName: result base.
	self projectDirectory: result parent
]

{ #category : #'menu actions' }
SpScratchApp >> saveProjectNoDialog [
	| fName dir file |
	self closeMediaEditorsAndDialogs
		ifFalse: [ ^ self ].
	self stopAllProcesses.
	fName := self projectName.
	dir := ScratchDirectory current getLastFolderForType: #project.
	file := dir / (fName , '.' , self extension).
	file isFile
		ifFalse: [ ^ self saveProject ].
	ScratchDirectory current lastFolderIsSampleProjectsFolder
		ifTrue: [ self projectDirectory: ScratchDirectory current project.
			^ self saveProject ].
	project
		thumbnailForm: (presenter stageShotExtent: self class thumbnailExtent).
	(project writeProjectAs: file)
		ifFalse: [ ^ self ].
	self projectName: file base.
	self projectDirectory: file parent
]

{ #category : #private }
SpScratchApp >> saveScratchFileFor: aProject [
	| dialog |
	dialog := SpFileChooserDialog new.
	dialog
		filename: self projectName;
		extension: self extension;
		setupForFileInfoEditor;
		title: 'Save Project';
		type: #project;
		author: aProject author;
		comment: aProject comment.
	[ (dialog openModalWithSpec: #saveScratchFileSpec) isCancelled
		ifTrue: [ ^ nil ].
	dialog filename isNil ] whileTrue.
	aProject
		author: dialog author;
		comment: dialog comment.
	^ dialog filename
]

{ #category : #'menu actions' }
SpScratchApp >> saveScriptsToImage [
	"Take a snapshot of all scripts for a sprite and save as a GIF file"

	| fName saveForm pngExt |
	pngExt := 'png'.
	saveForm := presenter scriptForm.
	saveForm ifNil: [ ^ self ].
	fName := self
		chooseNewFileDefault: ''
		extension: pngExt
		title: 'Save Scripts Snapshot'
		type: #scriptsSnapshot.
	fName ifNil: [ ^ self ].
	fName := fName withExtension: pngExt.
	saveForm writePNGFileNamed: fName pathString
]

{ #category : #private }
SpScratchApp >> setupView [
	| viewTarget |
	viewTarget := project scripts first.
	project scripts
		do: [ :m | 
			m scripts size > viewTarget scripts size
				ifTrue: [ viewTarget := m ] ].
	presenter target: viewTarget
]

{ #category : #processes }
SpScratchApp >> startProcessFor: topBlock [
	self subclassResponsibility
]

{ #category : #processes }
SpScratchApp >> stepProcesses [
	process ifNil: [ ^ self ].
	process step.
	updateInfoCount := updateInfoCount + 1.
	updateInfoCount > self maxUpdateInfoCount
		ifTrue: [ updateInfoCount := 0.
			self updateInfo ].
	presenter updateDisplay.
	self stepProcessesHook
]

{ #category : #processes }
SpScratchApp >> stepProcessesHook [
	"do nothing"
]

{ #category : #processes }
SpScratchApp >> stopAllProcesses [
	process ifNil: [ ^ self ].
	process stop.
	process := nil
]

{ #category : #accessing }
SpScratchApp >> updateContents [
	presenter updateContents
]

{ #category : #processes }
SpScratchApp >> updateInfo [
	self subclassResponsibility
]
