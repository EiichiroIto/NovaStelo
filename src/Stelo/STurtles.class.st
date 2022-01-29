Class {
	#name : #STurtles,
	#superclass : #SBreed,
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
	^ self flag: varId class aliveFlagNo at: index
]

{ #category : #'accessing variable' }
STurtles >> aliveAt: index put: aBoolean [
	self flag: varId class aliveFlagNo at: index put: aBoolean.
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

{ #category : #microworld }
STurtles >> breedsAtPoint: aPoint [
	| list x y |
	x := aPoint x truncated.
	y := aPoint y truncated.
	list := OrderedCollection new.
	self
		livingOnesDo: [ :index | 
			((self xAt: index) truncated = x and: [ (self yAt: index) truncated = y ])
				ifTrue: [ list add: index ] ].
	^ list
]

{ #category : #microworld }
STurtles >> copyTurtleFrom: anInteger1 to: anInteger2 [
	variables copyElementFrom: anInteger1 to: anInteger2
]

{ #category : #microworld }
STurtles >> countAlive [
	| ret |
	ret := 0.
	self livingOnesDo: [ :each | ret := ret + 1 ].
	^ ret
]

{ #category : #microworld }
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

{ #category : #microworld }
STurtles >> defaultPosition [
	^ defaultPosition
]

{ #category : #microworld }
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
	^ self var: varId class headingVarNo at: anInteger
]

{ #category : #'accessing variable' }
STurtles >> headingAt: anInteger put: aNumber [
	self var: varId class headingVarNo at: anInteger put: aNumber.
]

{ #category : #'object i/o' }
STurtles >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(defaultColor #breedNo) from: anObjStream.
]

{ #category : #initialization }
STurtles >> initialize [
	super initialize.
	defaultColor := SColorList atRandom.
	defaultPosition := 0 @ 0.
	self clear.
]

{ #category : #microworld }
STurtles >> killAt: anIndex [
	self aliveAt: anIndex put: false.
]

{ #category : #microworld }
STurtles >> livingOnesDo: aBlock [
	1 to: self size do: [ :each | 
		(self flag: varId class aliveFlagNo at: each)
			ifTrue: [ aBlock value: each ] ]
]

{ #category : #'accessing variable' }
STurtles >> penDownAt: anInteger [
	^ self flag: varId class penDownFlagNo at: anInteger
]

{ #category : #'accessing variable' }
STurtles >> penDownAt: anInteger put: aBoolean [
	self flag: varId class penDownFlagNo at: anInteger put: aBoolean.
]

{ #category : #printing }
STurtles >> printOn: aStream [
	aStream
		nextPutAll: 'Turtles(';
		nextPutAll: self countAlive asString;
		nextPut: $).
]

{ #category : #initialization }
STurtles >> reset [
	varId := STurtleVarDef new.
	variables := Variables new updateVarDef: varId.
]

{ #category : #microworld }
STurtles >> setupAt: index [
	self colorAt: index put: self defaultColor.
	self aliveAt: index put: true.
	self xAt: index put: self defaultPosition x.
	self yAt: index put: self defaultPosition y.
	self headingAt: index put: 360 atRandom - 1.0.
	self penDownAt: index put: false
]

{ #category : #microworld }
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
	anInteger = varId class colorVarNo
		ifTrue: [ data := SColorList default normalize: data.
			defaultColor := data ].
	anInteger = varId class headingVarNo
		ifTrue: [ data := aNumber \\ 360 ].
	super var: anInteger at: id put: data
]

{ #category : #'accessing variable' }
STurtles >> xAt: anInteger [
	^ self var: varId class xVarNo at: anInteger
]

{ #category : #'accessing variable' }
STurtles >> xAt: anInteger put: aNumber [
	self var: varId class xVarNo at: anInteger put: aNumber.
]

{ #category : #'accessing variable' }
STurtles >> yAt: anInteger [
	^ self var: varId class yVarNo at: anInteger
]

{ #category : #'accessing variable' }
STurtles >> yAt: anInteger put: aNumber [
	self var: varId class yVarNo at: anInteger put: aNumber.
]
