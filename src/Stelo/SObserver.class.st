Class {
	#name : #SObserver,
	#superclass : #SBreed,
	#instVars : [
		'breedId',
		'ticks'
	],
	#category : #'Stelo-Model'
}

{ #category : #accessing }
SObserver >> aliveAt: index [
	^ index = 1
]

{ #category : #accessing }
SObserver >> breedId [
	^ breedId
]

{ #category : #accessing }
SObserver >> breedName [
	^ 'Observer'
]

{ #category : #accessing }
SObserver >> breedNo [
	^ SBreedId observerBreedNo
]

{ #category : #accessing }
SObserver >> breedNo: anInteger [
	"do nothing"
]

{ #category : #microworld }
SObserver >> clearTicks [
	ticks := 0.
]

{ #category : #accessing }
SObserver >> colors [
	self shouldNotImplement.
]

{ #category : #'object i/o' }
SObserver >> fieldsVersion [
	^ 1
]

{ #category : #microworld }
SObserver >> incrementTicks [
	ticks := ticks + 1.
]

{ #category : #'object i/o' }
SObserver >> initFieldsFrom: anObjStream version: classVersion [
	super initFieldsFrom: anObjStream version: classVersion.
	self initFieldsNamed: #(breedId ticks) from: anObjStream.
]

{ #category : #initialization }
SObserver >> initialize [
	super initialize.
	breedId := SBreedId new.
	ticks := 0.
]

{ #category : #enumerating }
SObserver >> livingOnesDo: aBlock [
	aBlock value: 1.
]

{ #category : #accessing }
SObserver >> newTurtle [
	| bid breed |
	bid := breedId newNo.
	breed := STurtles new breedNo: bid.
	^ breed
]

{ #category : #initialization }
SObserver >> reset [
	varDef := SObserverVarDef new.
	variables := Variables new updateVarDef: varDef
]

{ #category : #microworld }
SObserver >> size [
	^ 1
]

{ #category : #'object i/o' }
SObserver >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(breedId ticks) on: anObjStream.
]

{ #category : #microworld }
SObserver >> ticks [
	^ ticks
]

{ #category : #microworld }
SObserver >> var: anInteger at: dummy put: anObject sworld: aWorld [
	anInteger = varDef class ticksVarNo
		ifTrue: [ ^ ticks := anObject ].
	self var: anInteger at: dummy put: anObject
]

{ #category : #microworld }
SObserver >> var: anInteger at: id sworld: aWorld [
	| v |
	v := varDef class.
	anInteger = v widthVarNo
		ifTrue: [ ^ aWorld extent x ].
	anInteger = v heightVarNo
		ifTrue: [ ^ aWorld extent y ].
	anInteger = v maxBreedNoVarNo
		ifTrue: [ ^ aWorld maxBreedNo ].
	anInteger = v ticksVarNo
		ifTrue: [ ^ ticks ].
	anInteger = v countAliveVarNo
		ifTrue: [ ^ aWorld countAliveOf: id ].
	anInteger = v sizeVarNo
		ifTrue: [ ^ aWorld sizeOf: id ].
	anInteger = v maxVarVarNo
		ifTrue: [ ^ varDef size ].
	^ self var: anInteger at: id
]
