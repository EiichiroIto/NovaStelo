Class {
	#name : #SteloBreed,
	#superclass : #Object,
	#instVars : [
		'variables',
		'varDef'
	],
	#category : #'Stelo-Model'
}

{ #category : #api }
SteloBreed >> addList: aString [

	| id |
	id := varDef addList: aString.
	variables updateVarDef: varDef.
	"self livingOnesDo: [ :each | self var: id list: each set: Array new ]."
	^ id
]

{ #category : #api }
SteloBreed >> addVariable: aString [
	| id |
	id := varDef addVariable: aString.
	variables updateVarDef: varDef.
	^ id
]

{ #category : #accessing }
SteloBreed >> aliveAt: anInteger [
	self subclassResponsibility
]

{ #category : #accessing }
SteloBreed >> breedName [
	self subclassResponsibility
]

{ #category : #accessing }
SteloBreed >> breedNo [
	self subclassResponsibility
]

{ #category : #accessing }
SteloBreed >> breedNo: anInteger [
	self subclassResponsibility
]

{ #category : #api }
SteloBreed >> clear [

	"this method clears all variable values with keeping its definition"

	variables ifNil: [ ^ self ].
	variables clear
]

{ #category : #api }
SteloBreed >> clearAt: id [

	| varNo |
	self userDefinedVarNames do: [ :each | 
		varNo := self varNoFor: each.
		self var: varNo at: id put: 0 ].
	self userDefinedListNames do: [ :each | 
		varNo := self varNoFor: each.
		self var: varNo list: id set: #(  ) ]
]

{ #category : #'accessing variable' }
SteloBreed >> colorAt: anInteger [
	^ variables var: varDef class colorVarNo at: anInteger
]

{ #category : #'accessing variable' }
SteloBreed >> colorAt: index put: anInteger [
	self var: varDef class colorVarNo at: index put: anInteger
]

{ #category : #accessing }
SteloBreed >> colors [
	^ variables realArrayAt: varDef class colorVarNo
]

{ #category : #'accessing variable' }
SteloBreed >> copyVar: var to: var2 [
	variables copyVar: var to: var2
]

{ #category : #accessing }
SteloBreed >> countAlive [
	^ self size
]

{ #category : #api }
SteloBreed >> deleteVariable: aString [
	varDef delete: aString.
	variables updateVarDef: varDef.
]

{ #category : #'object i/o' }
SteloBreed >> fieldsVersion [
	^ 1
]

{ #category : #api }
SteloBreed >> fixVars [
	varDef fixVars.
	variables ifNotNil: [ variables fixVars: varDef ].
]

{ #category : #'accessing variable' }
SteloBreed >> flag: anInteger at: id [
	| vars v b |
	vars := variables varAt: varDef class flagVarNo.
	b := 1 << anInteger.
	v := vars at: id.
	^ (v bitAnd: b) > 0
]

{ #category : #'accessing variable' }
SteloBreed >> flag: anInteger at: id put: aBoolean [
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
SteloBreed >> initFieldsFrom: anObjStream version: classVersion [
	self initFieldsNamed: #(varDef variables) from: anObjStream.
]

{ #category : #initialization }
SteloBreed >> initialize [
	self reset.
]

{ #category : #enumerating }
SteloBreed >> livingOnesDo: aBlock [
	self subclassResponsibility.
]

{ #category : #'instance creation' }
SteloBreed >> newVarDef [

	^ VarDef new
		  setupVarNames;
		  yourself
]

{ #category : #accessing }
SteloBreed >> realVarNames [
	^ varDef realVarNames
]

{ #category : #api }
SteloBreed >> reset [

	"this method clears all variable with its definitions"

	varDef := self newVarDef.
	variables := Variables new updateVarDef: varDef
]

{ #category : #api }
SteloBreed >> scaleVarNo: vid color: anInteger from: aNumber1 to: aNumber2 index: id [
	| v c |
	v := variables var: vid at: id.
	c := ColorList
		scaleValue: v
		color: anInteger
		from: aNumber1
		to: aNumber2.
	self colorAt: id put: c
]

{ #category : #accessing }
SteloBreed >> size [
	self subclassResponsibility.
]

{ #category : #'object i/o' }
SteloBreed >> storeFieldsOn: anObjStream [
	self storeFieldsNamed: #(varDef variables) on: anObjStream.
]

{ #category : #accessing }
SteloBreed >> userDefinedListNames [
	^ varDef listNames
]

{ #category : #'accessing variable' }
SteloBreed >> userDefinedVarNames [
	^ (varDef userDefinedVarNames \ self userDefinedListNames) sorted
]

{ #category : #accessing }
SteloBreed >> userDefinedVarNoAndNames [
	^ varDef userDefinedVarNoAndNames
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger at: id [
	^ variables var: anInteger at: id
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger at: id put: aNumber [
	(variables varAt: anInteger) at: id put: aNumber.
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger list: id [
	^ variables var: anInteger list: id
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger list: id add: anObject [
	variables var: anInteger list: id add: anObject
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger list: id at: anInteger2 [
	^ variables var: anInteger list: id at: anInteger2
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger list: id at: anInteger2 put: aNumber [
	variables var: anInteger list: id at: anInteger2 put: aNumber
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger list: id contains: anInteger2 [
	^ variables var: anInteger list: id contains: anInteger2
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger list: id remove: anObject [
	variables var: anInteger list: id remove: anObject
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger list: id set: aCollection [
	variables var: anInteger list: id set: aCollection
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger listSizeOf: id [
	^ variables var: anInteger listSizeOf: id
]

{ #category : #'accessing variable' }
SteloBreed >> var: anInteger putAll: anObject [
	variables setVar: anInteger toAll: anObject.
]

{ #category : #'accessing variable' }
SteloBreed >> varArrayNamed: aString [
	| vno |
	vno := self varNoFor: aString.
	^ variables realArrayAt: vno
]

{ #category : #'accessing variable' }
SteloBreed >> varArrayNamed: aString put: aCollection [
	| vno |
	vno := self varNoFor: aString.
	^ variables setVar: vno toArray: aCollection
]

{ #category : #accessing }
SteloBreed >> varDef [
	^ varDef
]

{ #category : #accessing }
SteloBreed >> varDef: anObject [

	varDef := anObject
]

{ #category : #accessing }
SteloBreed >> varNames [
	^ varDef varNames
]

{ #category : #accessing }
SteloBreed >> varNoFor: aString [
	^ varDef varNoFor: aString
]

{ #category : #testing }
SteloBreed >> variableNameInUse: aString [
	^ varDef includes: aString
]

{ #category : #accessing }
SteloBreed >> variables [
	^ variables
]

{ #category : #accessing }
SteloBreed >> variables: anObject [

	variables := anObject
]
