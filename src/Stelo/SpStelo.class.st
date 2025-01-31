Class {
	#name : 'SpStelo',
	#superclass : 'SpScratchApp',
	#instVars : [
		'sworld',
		'events',
		'lastMSec',
		'lastTicks',
		'recorder',
		'process'
	],
	#category : 'Stelo-Spec2',
	#package : 'Stelo',
	#tag : 'Spec2'
}

{ #category : 'constants' }
SpStelo class >> aboutAppString [

	^ self appName , ' v' , self appVersion , '
Copyright © 2019 Eiichiro Ito (ghc02331@nifty.com)
All rights reserved.

Based on Scratch from the MIT Media Lab, v' , self basedVersion , '
Copyright © 2009 Massachusetts Institute of Technology.
All rights reserved.
'
]

{ #category : 'constants' }
SpStelo class >> appFolderName [
	^ 'stelo'
]

{ #category : 'constants' }
SpStelo class >> appName [
	^ 'NovaStelo'
]

{ #category : 'constants' }
SpStelo class >> appVersion [

	^ '1.2.7'
]

{ #category : 'constants' }
SpStelo class >> extension [
	^ 'sl'
]

{ #category : 'class initialization' }
SpStelo class >> initialize [
	"self initialize"
	ScratchTheme
		themesURL: self themesURL;
		setupThemeNamed: self appFolderName
]

{ #category : 'world menu' }
SpStelo class >> menuCommandOn: aBuilder [
	<worldMenu>
	(aBuilder item: #NovaStelo)
		order: 0.5;
		target: self;
		action: [self open]; 
		icon: self icon
]

{ #category : 'constants' }
SpStelo class >> presentationClass [
	^ SpSteloPresenter
]

{ #category : 'constants' }
SpStelo class >> previewClass [
	^ self projectClass
]

{ #category : 'constants' }
SpStelo class >> projectClass [
	^ SteloProject
]

{ #category : 'constants' }
SpStelo class >> recodingExtent [
	^ 400 @ 400
]

{ #category : 'constants' }
SpStelo class >> themesURL [
	^ 'https://github.com/EiichiroIto/NovaStelo/raw/master/misc/Themes.zip'
]

{ #category : 'button actions' }
SpStelo >> addTurtles [
	| script |
	script := project addNewTurtleScript.
	script setupBlockSpecs.
	sworld addBreed: script breed.
	^ script
]

{ #category : 'button actions' }
SpStelo >> clearPatches [

	project patches clear.
	presenter updateDisplay
]

{ #category : 'button actions' }
SpStelo >> clearTurtles [

	project turtleBreeds do: [ :each | each clear ].
	self updateStatusForced: true.
	presenter updateDisplay
]

{ #category : 'menu actions' }
SpStelo >> copyListToPlots [
	| listNames plots ret list vno |
	listNames := project observer userDefinedListNames.
	listNames isEmpty
		ifTrue: [ ^ self ].
	plots := (1 to: self plotter numChannels + 1) asArray.
	ret := SpSteloConvDialog listNames: listNames plots: plots.
	ret ifNil: [ ^ self ].
	vno := project observer varNoFor: ret first.
	list := sworld var: vno breed: SBreedId observerBreedNo list: 1.
	self plotter plot: ret second list: list
]

{ #category : 'menu actions' }
SpStelo >> copyPlotsToList [
	| listNames plots ret list vno |
	listNames := project observer userDefinedListNames.
	listNames isEmpty
		ifTrue: [ ^ self ].
	plots := (1 to: self plotter numChannels) asArray.
	ret := SpSteloConvDialog plots: plots listNames: listNames.
	ret ifNil: [ ^ self ].
	list := self plotter listOf: ret first.
	vno := project observer varNoFor: ret second.
	sworld
		var: vno
		breed: SBreedId observerBreedNo
		list: 1
		set: list
]

{ #category : 'button actions' }
SpStelo >> deleteTurtles: anInteger [
	| script |
	script := project scriptOf: anInteger.
	project deleteScript: script.
	sworld deleteBreed: script breed.
	presenter updateDisplay
]

{ #category : 'accessing' }
SpStelo >> eventIdFor: aSymbol [
	^ events at: aSymbol
]

{ #category : 'accessing' }
SpStelo >> events [

	^ events
]

{ #category : 'accessing' }
SpStelo >> events: anObject [

	events := anObject
]

{ #category : 'menu actions' }
SpStelo >> exportPlots [
	self export: SteloPlotsExporter new extension: self plotsExtension isBinary: false
]

{ #category : 'menu actions' }
SpStelo >> exportSexpCode [
	self export: (ScratchSexpExporter appName: self appName) extension: self sexpExtension isBinary: false
]

{ #category : 'menu actions' }
SpStelo >> importPlots [
	self import: SteloPlotsImporter new extension: self plotsExtension isBinary: false
]

{ #category : 'menu actions' }
SpStelo >> importSexpCode [
	self import: (ScratchSexpImporter appName: self appName) extension: self sexpExtension isBinary: false.
	presenter updateTurtles
]

{ #category : 'initialization' }
SpStelo >> initialize [
	super initialize.
	lastMSec := 0.
	lastTicks := 0
]

{ #category : 'private' }
SpStelo >> installNewProject: aProject [

	self stopAllProcesses.
	sworld := self newMicroWorld.
	project := aProject.
	project application: self.
	project setupWorld: sworld.
	project setupBlockSpecs.
	project fixVars.
	project modified: false.
	presenter sworld: sworld.
	self setupView.
	presenter updateTurtles.
	Smalltalk garbageCollect
]

{ #category : 'processes' }
SpStelo >> isProcessRunning [
	^ process notNil and: [ process isRunning ]
]

{ #category : 'testing' }
SpStelo >> isRecording [
	^ recorder notNil
]

{ #category : 'accessing' }
SpStelo >> lastMSec [

	^ lastMSec
]

{ #category : 'accessing' }
SpStelo >> lastMSec: anObject [

	lastMSec := anObject
]

{ #category : 'accessing' }
SpStelo >> lastTicks [

	^ lastTicks
]

{ #category : 'accessing' }
SpStelo >> lastTicks: anObject [

	lastTicks := anObject
]

{ #category : 'processes' }
SpStelo >> maxUpdateInfoCount [
	^ 50
]

{ #category : 'processes' }
SpStelo >> newCode [

	^ SteloBytecodeGenerator new
		  parser: ScratchBlockParser new;
		  yourself
]

{ #category : 'instance creation' }
SpStelo >> newMicroWorld [

	^ SMicroWorld new
]

{ #category : 'instance creation' }
SpStelo >> newObserver [
	^ SObserver new
]

{ #category : 'instance creation' }
SpStelo >> newPatches [
	^ SPatches new
]

{ #category : 'instance creation' }
SpStelo >> newPresenter [
	^ SpSteloPresenter basicNew
		application: self;
		initialize;
		whenStepsDo: [ self stepProcesses ]
]

{ #category : 'processes' }
SpStelo >> newProgram [
	^ SProgram new
]

{ #category : 'accessing' }
SpStelo >> observerScript [
	^ project scriptOf: SBreedId observerBreedNo
]

{ #category : 'accessing' }
SpStelo >> patchesScript [
	^ project scriptOf: SBreedId patchesBreedNo
]

{ #category : 'private' }
SpStelo >> plotsExtension [
	^ 'csv'
]

{ #category : 'accessing' }
SpStelo >> plotter [
	^ presenter plotter
]

{ #category : 'accessing' }
SpStelo >> process [

	^ process
]

{ #category : 'accessing' }
SpStelo >> process: anObject [

	process := anObject
]

{ #category : 'accessing' }
SpStelo >> recorder [

	^ recorder
]

{ #category : 'accessing' }
SpStelo >> recorder: anObject [
	recorder := anObject
]

{ #category : 'private' }
SpStelo >> restoreProject [

	project setupWorld: sworld
]

{ #category : 'processes' }
SpStelo >> runLoop [
	| program |
	self setupEvents.
	program := project programOf: events.
	process := sworld newProcess program: program.
	process loop.
	^ process
]

{ #category : 'processes' }
SpStelo >> runSetup [
	| program |
	self setupEvents.
	program := project programOf: events.
	process := sworld newProcess program: program.
	process startup.
	^ process
]

{ #category : 'accessing' }
SpStelo >> scriptOf: anInteger [
	^ project scriptOf: anInteger
]

{ #category : 'processes' }
SpStelo >> setupEvents [
	| result eventId |
	eventId := EventId new.
	result := Dictionary new.
	result at: #startup put: EventId startupEventNo.
	result at: #setup put: EventId setupEventNo.
	result at: #loop put: EventId loopEventNo.
	result at: #single put: EventId singleEventNo.
	project allEventNames do: [ :each | result at: each asSymbol put: eventId newNo ].
	events := result.
	^ events
]

{ #category : 'private' }
SpStelo >> sexpExtension [
	^ 'sts'
]

{ #category : 'menu actions' }
SpStelo >> showBytecode: topBlock [

	| code |
	code := self newCode
		        script: presenter target;
		        parseBlock: topBlock.
	code inspect
]

{ #category : 'button actions' }
SpStelo >> startEvent [
	| program menu eno |
	self stopAllProcesses.
	presenter stepTime: 0.
	self setupEvents.
	eno := 0.
	menu := presenter
		eventMenuFrom: events
		whenSelected: [ :v | eno := v ].
	menu ifNil: [ ^ self ].
	menu openWithSpecAt: self currentWorld cursorPoint.
	eno = 0 ifTrue: [ ^ self ].
	program := project programOf: events.
	process := sworld newProcess program: program.
	process event: eno.
	^ process
]

{ #category : 'button actions' }
SpStelo >> startLoop [
	self stopAllProcesses.
	presenter stepTime: 0.
	self runLoop
]

{ #category : 'button actions' }
SpStelo >> startLoopSlow [
	self stopAllProcesses.
	presenter stepTime: 500.
	self runLoop
]

{ #category : 'processes' }
SpStelo >> startProcessFor: topBlock [

	| code program |
	self stopAllProcesses.
	self setupEvents.
	code := self newCode
		        script: presenter target;
		        parseBlock: topBlock.
	program := self newProgram.
	program
		addCode: code;
		addEntryPoint: 1
		eventNo: EventId singleEventNo
		breedNo: topBlock receiver breedNo.
	process := sworld newProcess program: program.
	process single.
	^ process
]

{ #category : 'button actions' }
SpStelo >> startSetup [
	self stopAllProcesses.
	presenter stepTime: 0.
	self runSetup
]

{ #category : 'menu actions' }
SpStelo >> startStageRecording [

	| file |
	file := presenter
		        chooseForSaveFileReference:
		        'Start Stage Recording' localized
		        extensions: { 'gif' }
		        path: self projectPath.
	file ifNil: [ ^ self ].
	recorder := ScratchRecorder new
		            openFileNamed: file;
		            model: presenter;
		            extent: self class recodingExtent.
	self updateStatusForced: true
]

{ #category : 'button actions' }
SpStelo >> stepLoop [
	self stopAllProcesses.
	presenter stepTime: 0.
	self runLoop.
	self stepProcesses.
	self stopAllProcesses
]

{ #category : 'processes' }
SpStelo >> stepProcesses [
	| oldRunning |
	oldRunning := self isProcessRunning.
	oldRunning
		ifTrue: [ process step ].
	project ifNotNil: [ self updateStatusForced: false ].
	(oldRunning or: [ self isProcessRunning ])
		ifFalse: [ ^ self ].
	presenter updateDisplay.
	recorder ifNil: [ ^ self ].
	recorder writeForced: false
]

{ #category : 'button actions' }
SpStelo >> stopAll [
	presenter stepTime: 1000.
	self stopAllProcesses
]

{ #category : 'processes' }
SpStelo >> stopAllProcesses [
	process ifNil: [ ^ self ].
	process stop.
	process := nil
]

{ #category : 'menu actions' }
SpStelo >> stopStageRecording [
	recorder ifNil: [ ^ self ].
	recorder close.
	recorder := nil.
	self updateStatusForced: true
]

{ #category : 'private' }
SpStelo >> stringOfTicks: ticks fps: fps count: count [
	| stream |
	stream := String new writeStream.
	stream
		nextPutAll: ticks truncated asString;
		nextPutAll: ' ticks, ';
		nextPutAll: fps asString;
		nextPutAll: ' fps, ';
		nextPutAll: count asString;
		nextPutAll: ' turtles'.
	^ stream contents
]

{ #category : 'private' }
SpStelo >> stringOfWorldName: aString [
	| stream |
	stream := String new writeStream.
	stream
		nextPutAll: ' (';
		nextPutAll: aString;
		nextPut: $).
	self isRecording
		ifTrue: [ stream nextPutAll: ' (Recording)' localized ].
	^ stream contents
]

{ #category : 'accessing' }
SpStelo >> sworld [

	^ sworld
]

{ #category : 'accessing' }
SpStelo >> sworld: aWorld [

	sworld := aWorld
]

{ #category : 'accessing' }
SpStelo >> target: aScript [
	presenter target: aScript
]

{ #category : 'menu actions' }
SpStelo >> toggleStageRecording [
	self isRecording
		ifTrue: [ self stopStageRecording ]
		ifFalse: [ self startStageRecording ]
]

{ #category : 'accessing' }
SpStelo >> turtlesScripts [
	^ project scriptsForMenu
]

{ #category : 'private' }
SpStelo >> updateStatusForced: aBoolean [

	| msec str ticks fps count |
	sworld ifNil: [ ^ self ].
	msec := Time millisecondClockValue.
	(msec < (lastMSec + 1000) and: [ aBoolean not ]) ifTrue: [ ^ self ].
	presenter updateInspector.
	str := self stringOfWorldName: sworld worldName.
	presenter status: str.
	ticks := sworld ticks.
	fps := (ticks - lastTicks * 1000 / (msec - lastMSec)) truncated.
	count := (sworld countAliveOf: self target breedNo) asString.
	str := self stringOfTicks: ticks fps: fps count: count.
	presenter info: str.
	sworld plotList ifNotEmpty: [ :list | presenter addPlots: list ].
	lastTicks := ticks.
	lastMSec := msec
]

{ #category : 'accessing' }
SpStelo >> varsAt: anInteger [
	| stream breed v bno vno |
	stream := WriteStream on: Array new.
	stream
		nextPut:
			{'id'.
			anInteger}.
	breed := presenter target breed.
	bno := breed breedNo.
	breed varNames
		do: [ :each | 
			vno := breed varNoFor: each.
			v := self sworld var: vno breed: bno at: anInteger.
			stream
				nextPut:
					{each.
					v} ].
	^ stream contents
]
