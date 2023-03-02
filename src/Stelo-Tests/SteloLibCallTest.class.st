"
A SteloLibCallTest is a test class for testing the behavior of SteloLibCall
"
Class {
	#name : #SteloLibCallTest,
	#superclass : #TestCase,
	#instVars : [
		'pluginExists'
	],
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloLibCallTest >> defaultOrder [
	^ 6
]

{ #category : #private }
SteloLibCallTest >> defaultPatchSize [
	^ self defaultOrder * self defaultOrder
]

{ #category : #running }
SteloLibCallTest >> setUp [

	super setUp.
	pluginExists := true.
	[ SteloLibCall new reset ]
		on: Error
		do: [ pluginExists := false ]
]

{ #category : #running }
SteloLibCallTest >> tearDown [

	super tearDown.
	[ SteloLibCall new reset ]
		on: Error
		do: [  ]
]

{ #category : #test }
SteloLibCallTest >> testAddVariableNameBreedNo [
	| c x |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	x := c addVariable: 10 breed: SBreedId patchesBreedNo.
	self assert: x.
	x := c addVariable: 10 breed: SBreedId patchesBreedNo.
	self deny: x
]

{ #category : #test }
SteloLibCallTest >> testGetByteBreedId [
	| c x |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 1.
	c
		setByte: STurtlesVarDef colorVarNo
		breed: 3
		id: 1
		value: 10.
	x := c getByte: STurtlesVarDef colorVarNo breed: 3 id: 1.
	self assert: x equals: 10
]

{ #category : #test }
SteloLibCallTest >> testGetFloatBreedId [
	| c x |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	c createPatch: 10.
	x := c getFloat: SObserverVarDef widthVarNo breed: SBreedId observerBreedNo id: 1.
	self assert: x equals: 10.
]

{ #category : #test }
SteloLibCallTest >> testGetTypeBreed [
	| c t |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	c setupBreed: SBreedId turtlesBreedNo.
	t := c getType: STurtlesVarDef colorVarNo breed: SBreedId turtlesBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: STurtlesVarDef flagVarNo breed: SBreedId turtlesBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: STurtlesVarDef xVarNo breed: SBreedId turtlesBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: STurtlesVarDef yVarNo breed: SBreedId turtlesBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: STurtlesVarDef headingVarNo breed: SBreedId turtlesBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: SPatchesVarDef colorVarNo breed: SBreedId patchesBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: SPatchesVarDef xVarNo breed: SBreedId patchesBreedNo.
	self assert: t equals: SteloLibCall computedFloat.
	t := c getType: SPatchesVarDef yVarNo breed: SBreedId patchesBreedNo.
	self assert: t equals: SteloLibCall computedFloat.
	t := c getType: SPatchesVarDef screenVarNo breed: SBreedId patchesBreedNo.
	self assert: t equals: SteloLibCall byte.
]

{ #category : #test }
SteloLibCallTest >> testGetWordBreedId [
	| c x |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	c setupBreed: 3.
	x := c getByte: STurtlesVarDef flagVarNo breed: 3 id: 1.
	self assert: x equals: 0.
	x := c getByte: STurtlesVarDef flagVarNo breed: 3 id: 2.
	self assert: x equals: 0.
	x := c getByte: STurtlesVarDef flagVarNo breed: 3 id: 3.
	self assert: x equals: 0.
	c create: 3 turtles: 2.
	x := c getByte: STurtlesVarDef flagVarNo breed: 3 id: 1.
	self assert: x equals: 1.
	x := c getByte: STurtlesVarDef flagVarNo breed: 3 id: 2.
	self assert: x equals: 1.
	x := c getByte: STurtlesVarDef flagVarNo breed: 3 id: 3.
	self assert: x equals: 0.
]

{ #category : #test }
SteloLibCallTest >> testIsRunning [
	| c |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	self deny: c isRunning.

]

{ #category : #test }
SteloLibCallTest >> testPatchIndexAtXY [
	| c r |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	c createPatch: 10.
	r := c patchIndexAtX: -5 y: -5.
	self assert: r equals: 1.
	r := c patchIndexAtX: -4 y: -5.
	self assert: r equals: 2.
	r := c patchIndexAtX: 4 y: 4.
	self assert: r equals: 100.
	r := c patchIndexAtX: 0 y: 0.
	self assert: r equals: 56.
]

{ #category : #test }
SteloLibCallTest >> testSetByteAllBreedExtArraySize [
	| c ext x |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 3.
	ext := FFIExternalArray externalNewType: 'byte' size: 3.
	ext at: 1 put: 10.
	ext at: 2 put: 20.
	ext at: 3 put: 30.
	[ 	c setByteAll: STurtlesVarDef colorVarNo breed: 3 extArray: ext size: 3 ]
	ensure: [ ext release ].
	x := c getByte: STurtlesVarDef colorVarNo breed: 3 id: 1.
	self assert: x equals: 10.
	x := c getByte: STurtlesVarDef colorVarNo breed: 3 id: 2.
	self assert: x equals: 20.
	x := c getByte: STurtlesVarDef colorVarNo breed: 3 id: 3.
	self assert: x equals: 30.
]

{ #category : #test }
SteloLibCallTest >> testSetByteBreedIdValue [
	self testGetByteBreedId.
]

{ #category : #test }
SteloLibCallTest >> testSetFloatAllBreedExtArraySize [
	| c ext x |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 3.
	ext := FFIExternalArray externalNewType: 'float' size: 3.
	ext at: 1 put: 1.5.
	ext at: 2 put: 2.6.
	ext at: 3 put: 3.7.
	[ 	c setFloatAll: STurtlesVarDef xVarNo breed: 3 extArray: ext size: 3 ]
	ensure: [ ext release ].
	x := c getFloat: STurtlesVarDef xVarNo breed: 3 id: 1.
	self assert: x closeTo: 1.5.
	x := c getFloat: STurtlesVarDef xVarNo breed: 3 id: 2.
	self assert: x closeTo: 2.6.
	x := c getFloat: STurtlesVarDef xVarNo breed: 3 id: 3.
	self assert: x closeTo: 3.7.
]

{ #category : #test }
SteloLibCallTest >> testSetFloatBreedIdValue [
	| c x |
	pluginExists ifFalse: [ ^ self ].
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 1.
	x := c getFloat: STurtlesVarDef xVarNo breed: 3 id: 1.
	self assert: x closeTo: 0.
	c
		setFloat: STurtlesVarDef xVarNo
		breed: 3
		id: 1
		value: 1.0.
	x := c getFloat: STurtlesVarDef xVarNo breed: 3 id: 1.
	self assert: x closeTo: 1.
	c
		setFloat: SObserverVarDef ticksVarNo
		breed: SBreedId observerBreedNo
		id: 0
		value: 120.
	x := c
		getFloat: SObserverVarDef ticksVarNo
		breed: SBreedId observerBreedNo
		id: 0.
	self assert: x equals: 120.
	c
		setFloat: SObserverVarDef ticksVarNo
		breed: SBreedId observerBreedNo
		id: 0
		value: 10.
	x := c
		getFloat: SObserverVarDef ticksVarNo
		breed: SBreedId observerBreedNo
		id: 0.
	self assert: x equals: 10
]
