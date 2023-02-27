Class {
	#name : #SBreed,
	#superclass : #Object,
	#instVars : [
		'variables',
		'varDef'
	],
	#category : #'Stelo-Model'
}

{ #category : #accessing }
SBreed >> addList: aString [
	| id |
	id := varDef addList: aString.
	variables updateVarDef: varDef.
	^ id
]

{ #category : #accessing }
SBreed >> addVariable: aString [
	| id |
	id := varDef addVariable: aString.
	variables updateVarDef: varDef.
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

{ #category : #accessing }
SBreed >> clearAt: id [

	| varNo |
	self userDefinedVarNames do: [ :each | 
		varNo := self varNoFor: each.
		self var: varNo at: id put: 0 ].
	self userDefinedListNames do: [ :each | 
		varNo := self varNoFor: each.
		self var: varNo list: id set: #(  ) ]
]

{ #category : #'accessing variable' }
SBreed >> colorAt: anInteger [
	^ variables var: varDef class colorVarNo at: anInteger
]

{ #category : #'accessing variable' }
SBreed >> colorAt: index put: anInteger [
	self var: varDef class colorVarNo at: index put: anInteger
]

{ #category : #accessing }
SBreed >> colors [
	^ variables realArrayAt: varDef class colorVarNo
]

{ #category : #'accessing variable' }
SBreed >> copyVar: var to: var2 [
	variables copyVar: var to: var2
]

{ #category : #microworld }
SBreed >> countAlive [
	^ self size
]

{ #category : #accessing }
SBreed >> deleteVariable: aString [
	varDef delete: aString.
	variables updateVarDef: varDef.
]

{ #category : #'object i/o' }
SBreed >> fieldsVersion [
	^ 1
]

{ #category : #accessing }
SBreed >> fixVars [
	varDef fixVars.
	variables ifNotNil: [ variables fixVars: varDef ].
]

{ #category : #'accessing variable' }
SBreed >> flag: anInteger at: id [
	| vars v b |
	vars := variables varAt: varDef class flagVarNo.
	b := 1 << anInteger.
	v := vars at: id.
	^ (v bitAnd: b) > 0
]

{ #category : #'accessing variable' }
SBreed >> flag: anInteger at: id put: aBoolean [
	| vars v b |
	vars := variables varAt: varDef class flagVarNo.
	b := 1 << anInteger.
	v := vars at: id.
	v := aBoolean
		ifTrue: [ v bitOr: b ]
		ifFalse: [ v bitClear: b ].
	vars at: id put: v
]

{ #category : #'object i/o' }
SBreed >> initFieldsFrom: anObjStream version: classVersion [
	self initFieldsNamed: #(varDef variables) from: anObjStream.
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
	^ varDef realVarNames
]

{ #category : #initialization }
SBreed >> reset [
	"reset means clear all variable with its definitions"
	varDef := SBreedVarDef new.
	variables := Variables new updateVarDef: varDef.
]

{ #category : #microworld }
SBreed >> scaleVarNo: vid color: anInteger from: aNumber1 to: aNumber2 index: id [
	| v c |
	v := variables var: vid at: id.
	c := ColorList
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
	self storeFieldsNamed: #(varDef variables) on: anObjStream.
]

{ #category : #accessing }
SBreed >> userDefinedListNames [
	^ varDef listNames
]

{ #category : #'accessing variable' }
SBreed >> userDefinedVarNames [
	^ (varDef userDefinedVarNames \ self userDefinedListNames) sorted
]

{ #category : #accessing }
SBreed >> userDefinedVarNoAndNames [
	^ varDef userDefinedVarNoAndNames
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
SBreed >> varDef [
	^ varDef
]

{ #category : #accessing }
SBreed >> varNames [
	^ varDef varNames
]

{ #category : #accessing }
SBreed >> varNoFor: aString [
	^ varDef varNoFor: aString
]

{ #category : #accessing }
SBreed >> variableNameInUse: aString [
	^ varDef includes: aString
]
