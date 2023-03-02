Class {
	#name : #STurtles,
	#superclass : #SteloBreed,
	#instVars : [
		'defaultColor',
		'breedNo',
		'defaultPosition'
	],
	#category : #'Stelo-Model'
}

{ #category : #'accessing variable' }
STurtles >> aliveAt: index [
	(index between: 1 and: self size)
		ifFalse: [ ^ false ].
	^ self flag: varDef class aliveFlagNo at: index
]

{ #category : #'accessing variable' }
STurtles >> aliveAt: index put: aBoolean [
	self flag: varDef class aliveFlagNo at: index put: aBoolean.
]

{ #category : #accessing }
STurtles >> breedName [
	^ 'Turtle', breedNo asString
]

{ #category : #accessing }
STurtles >> breedNo [
	^ breedNo
]

{ #category : #accessing }
STurtles >> breedNo: anInteger [
	breedNo := anInteger.
]

{ #category : #api }
STurtles >> copyTurtleFrom: anInteger1 to: anInteger2 [
	variables copyElementFrom: anInteger1 to: anInteger2
]

{ #category : #accessing }
STurtles >> countAlive [
	| ret |
	ret := 0.
	self livingOnesDo: [ :each | ret := ret + 1 ].
	^ ret
]

{ #category : #api }
STurtles >> create: anInteger [
	| rest tno list |
	rest := anInteger.
	list := OrderedCollection new.
	tno := 1.
	[ rest > 0 ]
		whileTrue: [ (self aliveAt: tno)
				ifFalse: [ self setupAt: tno.
					list add: tno.
					rest := rest - 1 ].
				tno := tno + 1 ].
	^ list
]

{ #category : #accessing }
STurtles >> defaultColor [
	^ defaultColor
]

{ #category : #accessing }
STurtles >> defaultColor: anObject [

	defaultColor := anObject
]

{ #category : #accessing }
STurtles >> defaultPosition [
	^ defaultPosition
]

{ #category : #accessing }
STurtles >> defaultPosition: aPoint [
	defaultPosition := aPoint.
]

{ #category : #'accessing variable' }
STurtles >> deltaAt: anInteger [
	| h |
	h := self headingAt: anInteger.
	^ Point r: 1.0 degrees: h
]

{ #category : #'object i/o' }
STurtles >> fieldsVersion [
	^ 1
]

{ #category : #'accessing variable' }
STurtles >> headingAt: anInteger [
	^ self var: varDef class headingVarNo at: anInteger
]

{ #category : #'accessing variable' }
STurtles >> headingAt: anInteger put: aNumber [
	self var: varDef class headingVarNo at: anInteger put: aNumber.
]

{ #category : #'object i/o' }
STurtles >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(defaultColor #breedNo) from: anObjStream.
]

{ #category : #initialization }
STurtles >> initialize [
	super initialize.
	defaultColor := ColorList default random.
	defaultPosition := 0 @ 0.
	self clear.
]

{ #category : #enumerating }
STurtles >> livingOnesDo: aBlock [
	1 to: self size do: [ :each | 
		(self flag: varDef class aliveFlagNo at: each)
			ifTrue: [ aBlock cull: each cull: self ] ]
]

{ #category : #'instance creation' }
STurtles >> newVarDef [

	^ STurtlesVarDef new
]

{ #category : #'accessing variable' }
STurtles >> penDownAt: anInteger [
	^ self flag: varDef class penDownFlagNo at: anInteger
]

{ #category : #'accessing variable' }
STurtles >> penDownAt: anInteger put: aBoolean [
	self flag: varDef class penDownFlagNo at: anInteger put: aBoolean.
]

{ #category : #printing }
STurtles >> printOn: aStream [
	aStream
		nextPutAll: 'Turtles(';
		nextPutAll: self countAlive asString;
		nextPut: $).
]

{ #category : #private }
STurtles >> setupAt: index [
	self clearAt: index.
	self colorAt: index put: self defaultColor.
	self aliveAt: index put: true.
	self xAt: index put: self defaultPosition x.
	self yAt: index put: self defaultPosition y.
	self headingAt: index put: 360 atRandom - 1.0.
	self penDownAt: index put: false
]

{ #category : #accessing }
STurtles >> size [
	^ variables max
]

{ #category : #'object i/o' }
STurtles >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(defaultColor #breedNo) on: anObjStream.
]

{ #category : #'accessing variable' }
STurtles >> var: anInteger at: id put: aNumber [
	| data |
	data := aNumber.
	anInteger = varDef class colorVarNo
		ifTrue: [ defaultColor := data ].
	anInteger = varDef class headingVarNo
		ifTrue: [ data := aNumber \\ 360 ].
	super var: anInteger at: id put: data
]

{ #category : #'accessing variable' }
STurtles >> xAt: anInteger [
	^ self var: varDef class xVarNo at: anInteger
]

{ #category : #'accessing variable' }
STurtles >> xAt: anInteger put: aNumber [
	self var: varDef class xVarNo at: anInteger put: aNumber.
]

{ #category : #'accessing variable' }
STurtles >> yAt: anInteger [
	^ self var: varDef class yVarNo at: anInteger
]

{ #category : #'accessing variable' }
STurtles >> yAt: anInteger put: aNumber [
	self var: varDef class yVarNo at: anInteger put: aNumber.
]
