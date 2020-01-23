"
A SObserverVarIdTest is a test class for testing the behavior of SObserverVarId
"
Class {
	#name : #SObserverVarDefTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #'tests-accessing' }
SObserverVarDefTest >> testCountAliveVarNo [
	self assert: SObserverVarDef countAliveVarNo equals: 5.
]

{ #category : #'tests-accessing' }
SObserverVarDefTest >> testHeightVarNo [
	self assert: SObserverVarDef heightVarNo equals: 2.
]

{ #category : #'tests-initialization' }
SObserverVarDefTest >> testInitialize [
	| o |
	o := SObserverVarDef new.
	self assert: o size equals: 7.
	self assert: (o varNoFor: 'width') equals: SObserverVarDef widthVarNo.
	self assert: (o varNoFor: 'height') equals: SObserverVarDef heightVarNo.
	self assert: (o varNoFor: 'maxBreedNo') equals: SObserverVarDef maxBreedNoVarNo.
	self assert: (o varNoFor: 'ticks') equals: SObserverVarDef ticksVarNo.
	self assert: (o varNoFor: 'countAlive') equals: SObserverVarDef countAliveVarNo.
	self assert: (o varNoFor: 'size') equals: SObserverVarDef sizeVarNo.
	self assert: (o varNoFor: 'maxVar') equals: SObserverVarDef maxVarVarNo.
]

{ #category : #'tests-accessing' }
SObserverVarDefTest >> testMaxBreedNoVarNo [
	self assert: SObserverVarDef maxBreedNoVarNo equals: 3.
]

{ #category : #'tests-accessing' }
SObserverVarDefTest >> testMaxVarVarNo [
	self assert: SObserverVarDef maxVarVarNo equals: 7.
]

{ #category : #'tests-accessing' }
SObserverVarDefTest >> testReservedVarNames [
	self
		assertCollection: SObserverVarDef new privReservedVarNames
		equals: #(width height maxBreedNo ticks countAlive size maxVar)
]

{ #category : #'tests-accessing' }
SObserverVarDefTest >> testSizeVarNo [
	self assert: SObserverVarDef sizeVarNo equals: 6.
]

{ #category : #'tests-accessing' }
SObserverVarDefTest >> testTicksVarNo [
	self assert: SObserverVarDef ticksVarNo equals: 4.
]

{ #category : #'tests-accessing' }
SObserverVarDefTest >> testWidthVarNo [
	self assert: SObserverVarDef widthVarNo equals: 1.
]
