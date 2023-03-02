"
A SpSteloTest is a test class for testing the behavior of SpStelo
"
Class {
	#name : #SpSteloTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SpSteloTest >> newApp [

	| app |
	app := SpStelo new.
	app settings: SpStelo settingsClass new.
	app presenter: app newPresenter.
	^ app
]

{ #category : #private }
SpSteloTest >> newProject [
	^ SteloProject new
]

{ #category : #test }
SpSteloTest >> testAddTurtles [
	| app proj ret |
	app := self newApp.
	proj := self newProject.
	app installNewProject: proj.
	self assert: proj scripts size equals: 3.
	self assert: app sworld breeds size equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 4.
	self assert: proj scripts size equals: 4.
	self assert: app sworld breeds size equals: 4.
	self assert: (ret isKindOf: TurtlesScript).
	self assert: (proj scriptOf: 4) equals: ret.
	self assert: (app sworld breedOf: 4) equals: ret breed
]

{ #category : #test }
SpSteloTest >> testDeleteTurtles [
	| app proj ret t3 t4 |
	app := self newApp.
	proj := self newProject.
	app installNewProject: proj.
	self assert: proj scripts size equals: 3.
	self assert: app sworld breeds size equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 4.
	t3 := proj scriptOf: 3.
	t4 := proj scriptOf: 4.
	self assert: ret equals: t4.
	app deleteTurtles: 4.
	self assert: proj scripts size equals: 3.
	self
		assert: (app sworld breeds count: [ :each | each notNil ])
		equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 5.
	self assert: (proj scriptOf: 3) equals: t3.
	t4 := proj scriptOf: 5.
	self assert: ret equals: t4.
	app deleteTurtles: 3.
	self assert: (proj scriptOf: 5) equals: t4.
	self assert: proj scripts size equals: 3.
	self
		assert: (app sworld breeds count: [ :each | each notNil ])
		equals: 3.
]

{ #category : #test }
SpSteloTest >> testEventIdFor [

	| app |
	app := self newApp.
	app installNewProject: self newProject.
	app setupEvents.
	self assert: (app eventIdFor: #startup) equals: EventId startupEventNo.
	self assert: (app eventIdFor: #setup) equals: EventId setupEventNo.
	self assert: (app eventIdFor: #loop) equals: EventId loopEventNo.
	self assert: (app eventIdFor: #single) equals: EventId singleEventNo
]

{ #category : #test }
SpSteloTest >> testEvents [

	| app d |
	app := self newApp.
	self assert: app events isNil.
	d := Dictionary new.
	app events: d.
	self assert: app events identicalTo: d
]

{ #category : #test }
SpSteloTest >> testInitialize [

	| app |
	app := self newApp.
	self assert: app lastMSec equals: 0.
	self assert: app lastTicks equals: 0
]

{ #category : #test }
SpSteloTest >> testIsProcessRunning [
	| app |
	app := self newApp.
	self deny: app isProcessRunning
]

{ #category : #test }
SpSteloTest >> testIsRecording [
	| a |
	a := self newApp.
	self deny: a isRecording.
	a recorder: true.
	self assert: a isRecording.
	a recorder: nil.
	self deny: a isRecording
]

{ #category : #test }
SpSteloTest >> testLastMSec [

	| app |
	app := self newApp.
	self assert: app lastMSec equals: 0.
	app lastMSec: 123.
	self assert: app lastMSec equals: 123.
	app lastMSec: 456.
	self assert: app lastMSec equals: 456
]

{ #category : #test }
SpSteloTest >> testLastTicks [

	| app |
	app := self newApp.
	self assert: app lastTicks equals: 0.
	app lastTicks: 123.
	self assert: app lastTicks equals: 123.
	app lastTicks: 456.
	self assert: app lastTicks equals: 456
]

{ #category : #test }
SpSteloTest >> testMaxUpdateInfoCount [

	self assert: self newApp maxUpdateInfoCount isInteger
]

{ #category : #test }
SpSteloTest >> testNewCode [

	| app |
	app := self newApp.
	self assert: (app newCode isKindOf: SteloBytecodeGenerator)
]

{ #category : #test }
SpSteloTest >> testNewMicroWorld [

	| app r |
	app := self newApp.
	r := app newMicroWorld.
	self assert: (r isKindOf: SMicroWorld)
]

{ #category : #test }
SpSteloTest >> testNewObserver [

	| app r |
	app := self newApp.
	r := app newObserver.
	self assert: (r isKindOf: SObserver)
]

{ #category : #test }
SpSteloTest >> testNewPatches [

	| app r |
	app := self newApp.
	r := app newPatches.
	self assert: (r isKindOf: SPatches)
]

{ #category : #test }
SpSteloTest >> testNewPresenter [

	| app r |
	app := self newApp.
	r := app newPresenter.
	self assert: (r isKindOf: SpSteloPresenter)
]

{ #category : #test }
SpSteloTest >> testNewProgram [

	| app |
	app := self newApp.
	self assert: (app newProgram isKindOf: SProgram)
]

{ #category : #test }
SpSteloTest >> testObserverScript [

	| app |
	app := self newApp.
	app installNewProject: self newProject.
	self assert: (app observerScript isKindOf: ObserverScript)
]

{ #category : #test }
SpSteloTest >> testPatchesScript [

	| app |
	app := self newApp.
	app installNewProject: self newProject.
	self assert: (app patchesScript isKindOf: PatchesScript)
]

{ #category : #test }
SpSteloTest >> testPlotsExtension [

	self assert: self newApp plotsExtension isString
]

{ #category : #test }
SpSteloTest >> testProcess [

	| app p |
	app := self newApp.
	self assert: app process isNil.
	p := SMicroWorld new newProcess.
	app process: p.
	self assert: app process identicalTo: p
]

{ #category : #test }
SpSteloTest >> testRecorder [
	self testIsRecording
]

{ #category : #test }
SpSteloTest >> testScriptOf [

	| app s |
	app := self newApp.
	app installNewProject: self newProject.
	s := app scriptOf: SBreedId observerBreedNo.
	self assert: (s isKindOf: ObserverScript).
	s := app scriptOf: SBreedId patchesBreedNo.
	self assert: (s isKindOf: PatchesScript)
]

{ #category : #test }
SpSteloTest >> testSetupEvents [

	| app |
	app := self newApp.
	app installNewProject: self newProject.
	self assert: app events isNil.
	app setupEvents.
	self assert: app events isDictionary.
	self assert: (app events at: #startup) equals: EventId startupEventNo.
	self assert: (app events at: #setup) equals: EventId setupEventNo.
	self assert: (app events at: #loop) equals: EventId loopEventNo.
	self assert: (app events at: #single) equals: EventId singleEventNo
]

{ #category : #test }
SpSteloTest >> testSexpExtension [

	self assert: self newApp sexpExtension isString
]

{ #category : #test }
SpSteloTest >> testStringOfTicksFpsCount [
	| a r |
	a := self newApp.
	r := a stringOfTicks: 123 fps: 456 count: 789.
	self assert: r equals: '123 ticks, 456 fps, 789 turtles'
]

{ #category : #test }
SpSteloTest >> testStringOfWorldName [
	| a r |
	a := self newApp.
	r := a stringOfWorldName: 'test'.
	self assert: r equals: ' (test)'.
	a recorder: true.
	r := a stringOfWorldName: 'abc'.
	self assert: r equals: ' (abc) (Recording)'
]

{ #category : #test }
SpSteloTest >> testSworld [

	| app w |
	app := self newApp.
	self assert: app sworld isNil.
	w := SMicroWorld new.
	app sworld: w.
	self assert: app sworld identicalTo: w
]

{ #category : #test }
SpSteloTest >> testVarsAt [
	| app proj s r |
	app := self newApp.
	proj := self newProject.
	app installNewProject: proj.
	s := app addTurtles.
	s setupBlockSpecs.
	app target: s.
	r := app varsAt: 1.
	self assert: r isArray.
	self assert: r size equals: 6
]
