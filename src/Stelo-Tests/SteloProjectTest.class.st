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
	^ SpStelo new
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
	proj privObserverScript: proj newObserverScript.
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
SteloProjectTest >> testPrivObserverScript [
	| app proj s |
	proj := self newProject.
	app := self newApp.
	proj application: app.
	self assert: proj privObserverScript isNil.
	s := proj newObserverScript.
	proj privObserverScript: s.
	proj addScript: s.
	self assert: proj privObserverScript equals: s.
	self assert: (proj scriptOf: 1) equals: s
]

{ #category : #test }
SteloProjectTest >> testPrivPatchesScript [
	| app proj s |
	proj := self newProject.
	app := self newApp.
	proj application: app.
	self assert: proj privPatchesScript isNil.
	s := proj newPatchesScript.
	proj privPatchesScript: s.
	proj addScript: s.
	self assert: proj privPatchesScript equals: s.
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
