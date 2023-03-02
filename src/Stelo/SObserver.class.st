Class {
	#name : #SObserver,
	#superclass : #SteloBreed,
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
SObserver >> breedId: anObject [

	breedId := anObject
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

{ #category : #api }
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

{ #category : #api }
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

{ #category : #'instance creation' }
SObserver >> newTurtles [
	| bid breed |
	bid := breedId newNo.
	breed := STurtles new breedNo: bid.
	^ breed
]

{ #category : #'instance creation' }
SObserver >> newVarDef [

	^ SObserverVarDef new
]

{ #category : #accessing }
SObserver >> size [
	^ 1
]

{ #category : #'object i/o' }
SObserver >> storeFieldsOn: anObjStream [
	super storeFieldsOn: anObjStream.
	self storeFieldsNamed: #(breedId ticks) on: anObjStream.
]

{ #category : #accessing }
SObserver >> ticks [
	^ ticks
]

{ #category : #accessing }
SObserver >> ticks: anObject [

	^ ticks := anObject
]

{ #category : #'accessing variable' }
SObserver >> var: anInteger at: id [

	anInteger = SObserverVarDef ticksVarNo ifTrue: [ ^ ticks ].
	anInteger = SObserverVarDef maxVarVarNo ifTrue: [ ^ varDef size ].
	^ super var: anInteger at: id
]

{ #category : #'accessing variable' }
SObserver >> var: anInteger at: id put: anObject [

	anInteger = SObserverVarDef ticksVarNo ifTrue: [ ^ ticks := anObject ].
	super var: anInteger at: id put: anObject
]
