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
	self assert: app sworld privBreeds size equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 4.
	self assert: proj scripts size equals: 4.
	self assert: app sworld privBreeds size equals: 4.
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
	self assert: app sworld privBreeds size equals: 3.
	ret := app addTurtles.
	self assert: ret breedNo equals: 4.
	t3 := proj scriptOf: 3.
	t4 := proj scriptOf: 4.
	self assert: ret equals: t4.
	app deleteTurtles: 4.
	self assert: proj scripts size equals: 3.
	self
		assert: (app sworld privBreeds count: [ :each | each notNil ])
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
		assert: (app sworld privBreeds count: [ :each | each notNil ])
		equals: 3.
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
	a privRecorder: true.
	self assert: a isRecording.
	a privRecorder: nil.
	self deny: a isRecording
]

{ #category : #test }
SpSteloTest >> testPrivRecorder [
	self testIsRecording
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
	a privRecorder: true.
	r := a stringOfWorldName: 'abc'.
	self assert: r equals: ' (abc) (Recording)'
]

{ #category : #test }
SpSteloTest >> testVarsAt [
	| app proj s r |
	app := self newApp.
	proj := self newProject.
	app installNewProject: proj.
	s := app addTurtles.
	app target: s.
	r := app varsAt: 1.
	self assert: r isArray.
	self assert: r size equals: 6
]
