Class {
	#name : #SBreed,
	#superclass : #Object,
	#instVars : [
		'varId',
		'variables'
	],
	#category : #'Stelo-Model'
}

{ #category : #accessing }
SBreed >> addList: aString [
	| id |
	id := varId addList: aString.
	variables updateVarDef: varId.
	^ id
]

{ #category : #accessing }
SBreed >> addVariable: aString [
	| id |
	id := varId addVariable: aString.
	variables updateVarDef: varId.
	^ id
]

{ #category : #accessing }
SBreed >> aliveAt: anInteger [
	self subclassResponsibility
]

{ #category : #accessing }
SBreed >> breedName [
	self subclassResponsibility
]

{ #category : #accessing }
SBreed >> breedNo [
	self subclassResponsibility
]

{ #category : #accessing }
SBreed >> breedNo: anInteger [
	self subclassResponsibility
]

{ #category : #microworld }
SBreed >> clear [
	"clear means clear all variable values with keeping its definition"
	variables ifNil: [ ^ self ].
	variables clear.
	"self halt.
	variables updateVarDef: varId"
]

{ #category : #'accessing variable' }
SBreed >> colorAt: anInteger [
	^ variables var: varId class colorVarNo at: anInteger
]

{ #category : #'accessing variable' }
SBreed >> colorAt: index put: anInteger [
	self var: varId class colorVarNo at: index put: anInteger
]

{ #category : #accessing }
SBreed >> colors [
	^ variables realArrayAt: varId class colorVarNo
]

{ #category : #microworld }
SBreed >> countAlive [
	^ self size
]

{ #category : #accessing }
SBreed >> deleteVariable: aString [
	varId delete: aString.
	variables updateVarDef: varId.
]

{ #category : #'object i/o' }
SBreed >> fieldsVersion [
	^ 1
]

{ #category : #accessing }
SBreed >> fixVars [
	varId fixVars.
	variables ifNotNil: [ variables fixVars: varId ].
]

{ #category : #'accessing variable' }
SBreed >> flag: anInteger at: id [
	| vars v b |
	vars := variables varAt: varId class flagVarNo.
	b := 1 << anInteger.
	v := vars at: id.
	^ (v bitAnd: b) > 0
]

{ #category : #'accessing variable' }
SBreed >> flag: anInteger at: id put: aBoolean [
	| vars v b |
	vars := variables varAt: varId class flagVarNo.
	b := 1 << anInteger.
	v := vars at: id.
	v := aBoolean
		ifTrue: [ v bitOr: b ]
		ifFalse: [ v bitClear: b ].
	vars at: id put: v
]

{ #category : #'object i/o' }
SBreed >> initFieldsFrom: anObjStream version: classVersion [
	self initFieldsNamed: #(varId variables) from: anObjStream.
]

{ #category : #initialization }
SBreed >> initialize [
	self reset.
]

{ #category : #microworld }
SBreed >> livingOnesDo: aBlock [
	self subclassResponsibility.
]

{ #category : #private }
SBreed >> privVariables [
	^ variables
]

{ #category : #accessing }
SBreed >> realVarNames [
	^ varId realVarNames
]

{ #category : #initialization }
SBreed >> reset [
	"reset means clear all variable with its definitions"
	varId := SBreedVarDef new.
	variables := Variables new updateVarDef: varId.
]

{ #category : #microworld }
SBreed >> scaleVarNo: vid color: anInteger from: aNumber1 to: aNumber2 index: id [
	| v c |
	v := variables var: vid at: id.
	c := SColorList
		scaleValue: v
		color: anInteger
		from: aNumber1
		to: aNumber2.
	self colorAt: id put: c
]

{ #category : #microworld }
SBreed >> size [
	self subclassResponsibility.
]

{ #category : #'object i/o' }
SBreed >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(varId variables) on: anObjStream.
]

{ #category : #accessing }
SBreed >> userDefinedListNames [
	^ varId listNames
]

{ #category : #'accessing variable' }
SBreed >> userDefinedVarNames [
	^ (varId userDefinedVarNames \ self userDefinedListNames) sorted
]

{ #category : #accessing }
SBreed >> userDefinedVarNoAndNames [
	^ varId userDefinedVarNoAndNames
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger at: id [
	^ variables var: anInteger at: id
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger at: id put: aNumber [
	(variables varAt: anInteger) at: id put: aNumber.
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger list: id [
	^ variables var: anInteger list: id
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger list: id add: anObject [
	variables var: anInteger list: id add: anObject
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger list: id at: anInteger2 [
	^ variables var: anInteger list: id at: anInteger2
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger list: id at: anInteger2 put: aNumber [
	variables var: anInteger list: id at: anInteger2 put: aNumber
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger list: id contains: anInteger2 [
	^ variables var: anInteger list: id contains: anInteger2
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger list: id remove: anObject [
	variables var: anInteger list: id remove: anObject
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger list: id set: aCollection [
	variables var: anInteger list: id set: aCollection
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger listSizeOf: id [
	^ variables var: anInteger listSizeOf: id
]

{ #category : #'accessing variable' }
SBreed >> var: anInteger putAll: anObject [
	variables setVar: anInteger toAll: anObject.
]

{ #category : #'accessing variable' }
SBreed >> varArrayNamed: aString [
	| vno |
	vno := self varNoFor: aString.
	^ variables realArrayAt: vno
]

{ #category : #'accessing variable' }
SBreed >> varArrayNamed: aString put: aCollection [
	| vno |
	vno := self varNoFor: aString.
	^ variables setVar: vno toArray: aCollection
]

{ #category : #accessing }
SBreed >> varId [
	^ varId
]

{ #category : #accessing }
SBreed >> varNames [
	^ varId varNames
]

{ #category : #accessing }
SBreed >> varNoFor: aString [
	^ varId varNoFor: aString
]

{ #category : #accessing }
SBreed >> variableNameInUse: aString [
	^ varId includes: aString
]
