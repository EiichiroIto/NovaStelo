Class {
	#name : 'SteloProject',
	#superclass : 'ScratchProject',
	#instVars : [
		'observerScript',
		'patchesScript'
	],
	#category : 'Stelo-Project',
	#package : 'Stelo',
	#tag : 'Project'
}

{ #category : 'accessing' }
SteloProject class >> fileVersion [
	^ 2
]

{ #category : 'accessing' }
SteloProject class >> fileVersionTag [
	^ 'SteloV'
]

{ #category : 'accessing' }
SteloProject class >> objStreamClass [
	^ SteloObjStream
]

{ #category : 'api' }
SteloProject >> addNewTurtleScript [
	| breed script |
	breed := self observer newTurtles.
	script := self newTurtlesScript
		breed: breed;
		yourself.
	self
		addScript: script;
		assignUniqueObjNameTo: script.
	^ script
]

{ #category : 'api' }
SteloProject >> addNewTurtleScriptNamed: aString [
	| breed script |
	breed := self observer newTurtles.
	script := self newTurtlesScript
		breed: breed;
		objName: aString;
		yourself.
	self addScript: script.
	^ script
]

{ #category : 'private' }
SteloProject >> assignUniqueObjNameTo: aScript [
	| name |
	aScript objName ifNotNil: [ ^ self ].
	name := aScript defaultObjName.
	[ (scripts noneSatisfy: [ :each | each objName = name ])
		ifTrue: [ ^ aScript objName: name ].
	name := name , 'x' ] repeat
]

{ #category : 'api' }
SteloProject >> assureExistsScriptNamed: aString [

	(self scriptNames includes: aString) ifTrue: [ ^ self ].
	self addNewTurtleScriptNamed: aString
]

{ #category : 'accessing' }
SteloProject >> breeds [

	^ scripts collect: #breed
]

{ #category : 'accessing' }
SteloProject >> eventIdFor: aSymbol [
	^ self application eventIdFor: aSymbol
]

{ #category : 'object i/o' }
SteloProject >> fieldsVersion [
	^ 1
]

{ #category : 'api' }
SteloProject >> fixVars [
	self breeds do: #fixVars
]

{ #category : 'object i/o' }
SteloProject >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self
		initFieldsNamed: #(observerScript patchesScript)
		from: anObjStream
]

{ #category : 'instance creation' }
SteloProject >> newObserverScript [
	^ ObserverScript new
		breed: application newObserver;
		project: self;
		yourself
]

{ #category : 'instance creation' }
SteloProject >> newPatchesScript [
	^ PatchesScript new
		breed: application newPatches;
		project: self;
		yourself
]

{ #category : 'instance creation' }
SteloProject >> newProgram [
	^ SProgram new
]

{ #category : 'instance creation' }
SteloProject >> newTurtlesScript [
	^ TurtlesScript new
		project: self;
		yourself
]

{ #category : 'accessing' }
SteloProject >> observer [
	^ observerScript breed
]

{ #category : 'accessing' }
SteloProject >> observerScript [
	^ observerScript
]

{ #category : 'accessing' }
SteloProject >> observerScript: aScript [
	observerScript := aScript
]

{ #category : 'argument menus' }
SteloProject >> observerVarNamesMenu [
	^ self observer userDefinedVarNames
]

{ #category : 'argument menus' }
SteloProject >> patchVarNamesMenu [
	^ self patches userDefinedVarNames
]

{ #category : 'accessing' }
SteloProject >> patches [
	^ patchesScript breed
]

{ #category : 'accessing' }
SteloProject >> patchesScript [
	^ patchesScript
]

{ #category : 'accessing' }
SteloProject >> patchesScript: aScript [
	patchesScript := aScript
]

{ #category : 'accessing' }
SteloProject >> programOf: aDictionary [

	| program |
	program := self newProgram.
	scripts do: [ :each | each setupProgram: program events: aDictionary ].
	^ program
]

{ #category : 'accessing' }
SteloProject >> scriptOf: bno [
	^ scripts detect: [ :each | each breed breedNo = bno ]
]

{ #category : 'accessing' }
SteloProject >> scriptsForMenu [

	^ scripts reject: [ :each | each breedNo < SBreedId turtlesBreedNo ]
]

{ #category : 'private' }
SteloProject >> setupScripts [
	observerScript
		ifNil: [ observerScript := self newObserverScript.
			self addScript: observerScript ].
	patchesScript
		ifNil: [ patchesScript := self newPatchesScript.
			self addScript: patchesScript ].
	self breeds size < 3
		ifTrue: [ self addNewTurtleScript ]
]

{ #category : 'api' }
SteloProject >> setupWorld: aWorld [

	self setupScripts.
	aWorld reset.
	scripts do: [ :each | aWorld addBreed: each breed ]
]

{ #category : 'object i/o' }
SteloProject >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(observerScript patchesScript) on: anObjStream.
]

{ #category : 'accessing' }
SteloProject >> turtleBreeds [
	^ self breeds reject: [ :each | each breedNo < SBreedId turtlesBreedNo ]
]

{ #category : 'argument menus' }
SteloProject >> turtleVarNamesMenu [
	| list |
	list := Set new.
	self turtleBreeds
		do: [ :each | list addAll: each userDefinedVarNames ].
	^ list asSortedCollection asArray
]

{ #category : 'accessing' }
SteloProject >> varNoFor: vno breed: bno [

	^ (self scriptOf: bno) varNoFor: vno
]
