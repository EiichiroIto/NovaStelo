"
A SteloLibCallTest is a test class for testing the behavior of SteloLibCall
"
Class {
	#name : #SteloLibCallTest,
	#superclass : #TestCase,
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
	SteloLibCall new reset.
]

{ #category : #running }
SteloLibCallTest >> tearDown [
	super tearDown.
	SteloLibCall new reset.
]

{ #category : #test }
SteloLibCallTest >> testAddVariableNameBreedNo [
	| c x |
	c := SteloLibCall new.
	x := c addVariable: 10 breed: SBreedId patchBreedNo.
	self assert: x.
	x := c addVariable: 10 breed: SBreedId patchBreedNo.
	self deny: x
]

{ #category : #test }
SteloLibCallTest >> testGetByteBreedId [
	| c x |
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 1.
	c
		setByte: STurtleVarDef colorVarNo
		breed: 3
		id: 1
		value: 10.
	x := c getByte: STurtleVarDef colorVarNo breed: 3 id: 1.
	self assert: x equals: 10
]

{ #category : #test }
SteloLibCallTest >> testGetFloatBreedId [
	| c x |
	c := SteloLibCall new.
	c createPatch: 10.
	x := c getFloat: SObserverVarDef widthVarNo breed: SBreedId observerBreedNo id: 1.
	self assert: x equals: 10.
]

{ #category : #test }
SteloLibCallTest >> testGetTypeBreed [
	| c t |
	c := SteloLibCall new.
	c setupBreed: SBreedId turtleBreedNo.
	t := c getType: STurtleVarDef colorVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: STurtleVarDef flagVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: STurtleVarDef xVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: STurtleVarDef yVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: STurtleVarDef headingVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: SPatchVarDef colorVarNo breed: SBreedId patchBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: SPatchVarDef xVarNo breed: SBreedId patchBreedNo.
	self assert: t equals: SteloLibCall computedFloat.
	t := c getType: SPatchVarDef yVarNo breed: SBreedId patchBreedNo.
	self assert: t equals: SteloLibCall computedFloat.
	t := c getType: SPatchVarDef screenVarNo breed: SBreedId patchBreedNo.
	self assert: t equals: SteloLibCall byte.
]

{ #category : #test }
SteloLibCallTest >> testGetWordBreedId [
	| c x |
	c := SteloLibCall new.
	c setupBreed: 3.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 1.
	self assert: x equals: 0.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 2.
	self assert: x equals: 0.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 3.
	self assert: x equals: 0.
	c create: 3 turtles: 2.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 1.
	self assert: x equals: 1.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 2.
	self assert: x equals: 1.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 3.
	self assert: x equals: 0.
]

{ #category : #test }
SteloLibCallTest >> testIsRunning [
	| c |
	c := SteloLibCall new.
	self deny: c isRunning.

]

{ #category : #test }
SteloLibCallTest >> testPatchIndexAtXY [
	| c r |
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
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 3.
	ext := FFIExternalArray externalNewType: 'byte' size: 3.
	ext at: 1 put: 10.
	ext at: 2 put: 20.
	ext at: 3 put: 30.
	[ 	c setByteAll: STurtleVarDef colorVarNo breed: 3 extArray: ext size: 3 ]
	ensure: [ ext release ].
	x := c getByte: STurtleVarDef colorVarNo breed: 3 id: 1.
	self assert: x equals: 10.
	x := c getByte: STurtleVarDef colorVarNo breed: 3 id: 2.
	self assert: x equals: 20.
	x := c getByte: STurtleVarDef colorVarNo breed: 3 id: 3.
	self assert: x equals: 30.
]

{ #category : #test }
SteloLibCallTest >> testSetByteBreedIdValue [
	self testGetByteBreedId.
]

{ #category : #test }
SteloLibCallTest >> testSetFloatAllBreedExtArraySize [
	| c ext x |
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 3.
	ext := FFIExternalArray externalNewType: 'float' size: 3.
	ext at: 1 put: 1.5.
	ext at: 2 put: 2.6.
	ext at: 3 put: 3.7.
	[ 	c setFloatAll: STurtleVarDef xVarNo breed: 3 extArray: ext size: 3 ]
	ensure: [ ext release ].
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 1.
	self assert: x closeTo: 1.5.
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 2.
	self assert: x closeTo: 2.6.
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 3.
	self assert: x closeTo: 3.7.
]

{ #category : #test }
SteloLibCallTest >> testSetFloatBreedIdValue [
	| c x |
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 1.
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 1.
	self assert: x closeTo: 0.
	c
		setFloat: STurtleVarDef xVarNo
		breed: 3
		id: 1
		value: 1.0.
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 1.
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
