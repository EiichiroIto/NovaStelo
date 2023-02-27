Class {
	#name : #SteloProject,
	#superclass : #ScratchProject,
	#instVars : [
		'observerScript',
		'patchesScript'
	],
	#category : #'Stelo-Project'
}

{ #category : #accessing }
SteloProject class >> fileVersion [
	^ 2
]

{ #category : #accessing }
SteloProject class >> fileVersionTag [
	^ 'SteloV'
]

{ #category : #accessing }
SteloProject class >> objStreamClass [
	^ SteloObjStream
]

{ #category : #variables }
SteloProject >> addList: aString var: vno breed: bno [
	application addList: aString var: vno breed: bno
]

{ #category : #accessing }
SteloProject >> addNewTurtleScript [
	| breed script |
	breed := self observer newTurtle.
	script := self newTurtlesScript
		breed: breed;
		yourself.
	self
		addScript: script;
		assignUniqueObjNameTo: script.
	^ script
]

{ #category : #accessing }
SteloProject >> addNewTurtleScriptNamed: aString [
	| breed script |
	breed := self observer newTurtle.
	script := self newTurtlesScript
		breed: breed;
		objName: aString;
		yourself.
	self addScript: script.
	^ script
]

{ #category : #variables }
SteloProject >> addVariable: aString var: vno breed: bno [
	application addVariable: aString var: vno breed: bno
]

{ #category : #private }
SteloProject >> assignUniqueObjNameTo: aScript [
	| name |
	aScript objName ifNotNil: [ ^ self ].
	name := aScript defaultObjName.
	[ (scripts noneSatisfy: [ :each | each objName = name ])
		ifTrue: [ ^ aScript objName: name ].
	name := name , 'x' ] repeat
]

{ #category : #accessing }
SteloProject >> assureExistsBreed: aString [
	((self scripts collect: #objName) includes: aString)
		ifTrue: [ ^ self ].
	self addNewTurtleScriptNamed: aString
]

{ #category : #accessing }
SteloProject >> breeds [
	^ self scripts collect: #breed
]

{ #category : #accessing }
SteloProject >> eventIdFor: aSymbol [
	^ self application eventIdFor: aSymbol
]

{ #category : #'object i/o' }
SteloProject >> fieldsVersion [
	^ 1
]

{ #category : #accessing }
SteloProject >> fixVars [
	self breeds do: #fixVars
]

{ #category : #'object i/o' }
SteloProject >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self
		initFieldsNamed: #(observerScript patchesScript)
		from: anObjStream
]

{ #category : #private }
SteloProject >> newObserverScript [
	^ ObserverScript new
		breed: application newObserver;
		project: self;
		yourself
]

{ #category : #private }
SteloProject >> newPatchesScript [
	^ PatchesScript new
		breed: application newPatches;
		project: self;
		yourself
]

{ #category : #private }
SteloProject >> newProgram [
	^ SProgram new
]

{ #category : #private }
SteloProject >> newTurtlesScript [
	^ TurtlesScript new
		project: self;
		yourself
]

{ #category : #accessing }
SteloProject >> observer [
	^ observerScript breed
]

{ #category : #'argument menus' }
SteloProject >> observerVarNamesMenu [
	^ self observer userDefinedVarNames
]

{ #category : #'argument menus' }
SteloProject >> patchVarNamesMenu [
	^ self patches userDefinedVarNames
]

{ #category : #accessing }
SteloProject >> patches [
	^ patchesScript breed
]

{ #category : #private }
SteloProject >> privObserverScript [
	^ observerScript
]

{ #category : #private }
SteloProject >> privObserverScript: aScript [
	observerScript := aScript
]

{ #category : #private }
SteloProject >> privPatchesScript [
	^ patchesScript
]

{ #category : #private }
SteloProject >> privPatchesScript: aScript [
	patchesScript := aScript
]

{ #category : #accessing }
SteloProject >> programOf: aDictionary [
	| program |
	program := self newProgram.
	self scripts
		do: [ :each | each setupProgram: program events: aDictionary ].
	^ program
]

{ #category : #accessing }
SteloProject >> scriptOf: bno [
	^ scripts detect: [ :each | each breed breedNo = bno ]
]

{ #category : #accessing }
SteloProject >> scriptsForMenu [
	^ self scripts reject: [ :each | each breedNo < SBreedId turtleBreedNo ]
]

{ #category : #private }
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

{ #category : #'object i/o' }
SteloProject >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(observerScript patchesScript) on: anObjStream.
]

{ #category : #accessing }
SteloProject >> turtleBreeds [
	^ self breeds reject: [ :each | each breedNo < SBreedId turtleBreedNo ]
]

{ #category : #'argument menus' }
SteloProject >> turtleVarNamesMenu [
	| list |
	list := Set new.
	self turtleBreeds
		do: [ :each | list addAll: each userDefinedVarNames ].
	^ list asSortedCollection asArray
]

{ #category : #accessing }
SteloProject >> varNoFor: vno breed: bno [

	^ (self scriptOf: bno) varNoFor: vno
]
