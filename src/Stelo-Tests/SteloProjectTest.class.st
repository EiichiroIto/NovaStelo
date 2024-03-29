"
A SteloProjectTest is a test class for testing the behavior of SteloProject
"
Class {
	#name : #SteloProjectTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloProjectTest >> newApp [

	| app |
	app := SpStelo new.
	app settings: SpStelo settingsClass new.
	app presenter: app newPresenter.
	^ app
]

{ #category : #private }
SteloProjectTest >> newProject [
	^ SteloProject new
]

{ #category : #private }
SteloProjectTest >> newTurtleScript [
	^ TurtlesScript new
]

{ #category : #test }
SteloProjectTest >> testAddNewTurtleScript [
	| app proj s |
	proj := self newProject.
	app := self newApp.
	proj application: app.
	proj observerScript: proj newObserverScript.
	s := proj addNewTurtleScript.
	self assert: (s isKindOf: TurtlesScript).
	self assert: s objName isString.
	self assert: (proj scripts includes: s).
	self assert: (s breed isKindOf: STurtles)
]

{ #category : #test }
SteloProjectTest >> testAssignUniqueObjNameTo [
	| proj s1 s2 s3 s |
	proj := self newProject.
	s1 := self newTurtleScript objName: 'a'.
	proj addScript: s1.
	s2 := self newTurtleScript objName: 'b'.
	proj addScript: s2.
	s := self newTurtleScript.
	s objName: 'abc'.
	proj assignUniqueObjNameTo: s.
	self assert: s objName equals: 'abc'.
	s := self newTurtleScript.
	s breed: (STurtles new breedNo: 3).
	self assert: s objName isNil.
	proj assignUniqueObjNameTo: s.
	self assert: s objName equals: s defaultObjName.
	s3 := self newTurtleScript objName: s defaultObjName.
	proj addScript: s3.
	s := self newTurtleScript.
	s breed: (STurtles new breedNo: 3).
	self assert: s objName isNil.
	proj assignUniqueObjNameTo: s.
	self assert: s objName equals: s defaultObjName , 'x'
]

{ #category : #test }
SteloProjectTest >> testObserverScript [
	| app proj s |
	proj := self newProject.
	app := self newApp.
	proj application: app.
	self assert: proj observerScript isNil.
	s := proj newObserverScript.
	proj observerScript: s.
	proj addScript: s.
	self assert: proj observerScript equals: s.
	self assert: (proj scriptOf: 1) equals: s
]

{ #category : #test }
SteloProjectTest >> testPatchesScript [
	| app proj s |
	proj := self newProject.
	app := self newApp.
	proj application: app.
	self assert: proj patchesScript isNil.
	s := proj newPatchesScript.
	proj patchesScript: s.
	proj addScript: s.
	self assert: proj patchesScript equals: s.
	self assert: (proj scriptOf: 2) equals: s
]

{ #category : #test }
SteloProjectTest >> testScriptOf [
	self testSetupScripts
]

{ #category : #test }
SteloProjectTest >> testSetupScripts [
	| app proj s |
	proj := self newProject.
	app := self newApp.
	app installNewProject: proj.
	proj setupScripts.
	s := proj scriptOf: 1.
	self assert: (s isKindOf: ObserverScript).
	s := proj scriptOf: 2.
	self assert: (s isKindOf: PatchesScript).
	s := proj scriptOf: 3.
	self assert: (s isKindOf: TurtlesScript)
]
