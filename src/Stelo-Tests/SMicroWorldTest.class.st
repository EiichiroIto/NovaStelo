"
A SMicroWorldTest is a test class for testing the behavior of SMicroWorld
"
Class {
	#name : #SMicroWorldTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SMicroWorldTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	w addNewTurtle.
	^ w
]

{ #category : #test }
SMicroWorldTest >> testAddBreed [

	| world |
	world := SMicroWorld new.
	self assert: world breeds isEmpty.
	world addBreed: (STurtles new breedNo: 3).
	world addBreed: (STurtles new breedNo: 4).
	self assert: world breeds size equals: 4.
	self
		should: [ world addBreed: (STurtles new breedNo: 3) ]
		raise: Error
]

{ #category : #test }
SMicroWorldTest >> testAddNewTurtle [

	| world t |
	world := self newWorld.
	self assert: world breeds size equals: 3.
	t := world addNewTurtle.
	self assert: (t isKindOf: STurtles).
	self assert: world breeds size equals: 4
]

{ #category : #test }
SMicroWorldTest >> testAimHighPatchVarBreedId [
	| w v ret |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 1.
	v := w patches addVariable: 'a'.
	"
	21 22 23 24 25
	16 17 18 19 20
	11 12 13 14 15
	 6  7  8  9 10
	 1  2  3  4  5
"
	w x: 3 at: 1 put: 0.
	w y: 3 at: 1 put: 0.
	w
		var: STurtlesVarDef headingVarNo
		breed: 3
		at: 1
		put: 45.
	w
		var: v
		breed: 2
		at: 18
		put: 1.
	w
		var: v
		breed: 2
		at: 19
		put: 2.
	w
		var: v
		breed: 2
		at: 14
		put: 3.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: -45.
	w
		var: v
		breed: 2
		at: 18
		put: 4.
	w
		var: v
		breed: 2
		at: 19
		put: 3.
	w
		var: v
		breed: 2
		at: 14
		put: 2.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: 45.
	w
		var: v
		breed: 2
		at: 18
		put: 4.
	w
		var: v
		breed: 2
		at: 19
		put: 5.
	w
		var: v
		breed: 2
		at: 14
		put: 2.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: 0.

	"
	21 22 23 24 25
	16 17 18 19 20
	11 12 13 14 15
	 6  7  8  9 10
	 1  2  3  4  5
"
	w
		var: STurtlesVarDef headingVarNo
		breed: 3
		at: 1
		put: 90.
	w
		var: v
		breed: 2
		at: 16
		put: 1.
	w
		var: v
		breed: 2
		at: 17
		put: 1.
	w
		var: v
		breed: 2
		at: 18
		put: 2.
	w
		var: v
		breed: 2
		at: 19
		put: 3.
	w
		var: v
		breed: 2
		at: 20
		put: 3.
	ret := w aimHighPatchVar: v breed: 3 id: 1.
	self assert: ret equals: -45
]

{ #category : #test }
SMicroWorldTest >> testBreedOf [

	| world r |
	world := self newWorld.
	r := world breedOf: SBreedId observerBreedNo.
	self assert: (r isKindOf: SObserver).
	r := world breedOf: SBreedId patchesBreedNo.
	self assert: (r isKindOf: SPatches).
	r := world breedOf: SBreedId turtlesBreedNo.
	self assert: (r isKindOf: STurtles)
]

{ #category : #test }
SMicroWorldTest >> testBreeds [

	| w a |
	w := self newWorld.
	self assert: w breeds isArray.
	self assert: (w breeds at: 1) class equals: SObserver.
	self assert: (w breeds at: 2) class equals: SPatches.
	self assert: (w breeds at: 3) class equals: STurtles.
	a := Array new.
	w breeds: a.
	self assert: w breeds identicalTo: a
]

{ #category : #test }
SMicroWorldTest >> testBreedsOf [
	| w |
	w := SMicroWorld new.
	w addBreed: (STurtles new breedNo: 3).
	self assert: (w breedOf: 3) class equals: STurtles.
]

{ #category : #test }
SMicroWorldTest >> testChangeBreedVarBy [

	| world v1 v2 |
	world := self newWorld.
	world createPatch: 2.
	v1 := world patches addVariable: 'abc'.
	v2 := world patches addVariable: 'def'.
	world changeBreed: SBreedId patchesBreedNo var: v1 by: 2.
	world changeBreed: SBreedId patchesBreedNo var: v2 by: 3.
	1 to: 4 do: [ :each | 
		self
			assert: (world var: v1 breed: SBreedId patchesBreedNo at: each)
			equals: 2.
		self
			assert: (world var: v2 breed: SBreedId patchesBreedNo at: each)
			equals: 3 ].
	world changeBreed: SBreedId patchesBreedNo var: v1 by: 1.
	world changeBreed: SBreedId patchesBreedNo var: v2 by: 2.
	1 to: 4 do: [ :each | 
		self
			assert: (world var: v1 breed: SBreedId patchesBreedNo at: each)
			equals: 3.
		self
			assert: (world var: v2 breed: SBreedId patchesBreedNo at: each)
			equals: 5 ]
]

{ #category : #test }
SMicroWorldTest >> testClearBreed [

	| world v1 v2 |
	world := self newWorld.
	world createPatch: 2.
	v1 := world patches addVariable: 'abc'.
	v2 := world patches addVariable: 'def'.
	world
		var: v1
		breed: SBreedId patchesBreedNo
		at: 1
		put: 5.
	world
		var: v2
		breed: SBreedId patchesBreedNo
		at: 2
		put: 6.
	self
		assert: (world var: v1 breed: SBreedId patchesBreedNo at: 1)
		equals: 5.
	self
		assert: (world var: v2 breed: SBreedId patchesBreedNo at: 2)
		equals: 6.
	world clearBreed: SBreedId patchesBreedNo.
	self
		assert: (world var: v1 breed: SBreedId patchesBreedNo at: 1)
		equals: 0.
	self
		assert: (world var: v2 breed: SBreedId patchesBreedNo at: 2)
		equals: 0
]

{ #category : #test }
SMicroWorldTest >> testClearPlots [
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w clearPlots.
	ret := w plotList.
	self assert: ret size equals: 1.
	self assert: ret first isClearPlot.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
]

{ #category : #test }
SMicroWorldTest >> testClearRaisedEvents [
	| w |
	w := SMicroWorld new.
	self assert: w raisedEvents isEmpty.
	w raiseEvent: #a.
	self assert: w raisedEvents notEmpty.
	w clearRaisedEvents.
	self assert: w raisedEvents isEmpty.
]

{ #category : #test }
SMicroWorldTest >> testClearTicks [

	| world |
	world := self newWorld.
	world observer ticks: 123.
	self assert: world observer ticks equals: 123.
	world clearTicks.
	self assert: world observer ticks equals: 0
]

{ #category : #test }
SMicroWorldTest >> testClearTurtles [

	| world v |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addVariable: 'abc'.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		at: 1
		put: 123.
	self
		assert: (world var: v breed: SBreedId turtlesBreedNo at: 1)
		equals: 123.
	self assert: (world aliveBreed: SBreedId turtlesBreedNo at: 1).
	world clearTurtles.
	self
		assert: (world var: v breed: SBreedId turtlesBreedNo at: 1)
		equals: 0.
	self deny: (world aliveBreed: SBreedId turtlesBreedNo at: 1)
]

{ #category : #test }
SMicroWorldTest >> testColors [
	| w |
	w := self newWorld.
	w createPatch: 3.
	self assertCollection: w colors equals: #[0 0 0 0 0 0 0 0 0].
	w create: 3 turtles: 1.
	(w breedOf: 3) colorAt: 1 put: 12.
	self assertCollection: w colors equals: #[0 0 0 0 12 0 0 0 0].
	w patches colorAt: 1 put: 23.
	self assertCollection: w colors equals: #[23 0 0 0 12 0 0 0 0]
]

{ #category : #test }
SMicroWorldTest >> testCopyBreedVarTo [

	| world v1 v2 t |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	t := world breedOf: SBreedId turtlesBreedNo.
	v1 := t addVariable: 'abc'.
	v2 := t addVariable: 'def'.
	t var: v1 at: 1 put: 123.
	self assert: (t var: v1 at: 1) equals: 123.
	self assert: (t var: v2 at: 1) equals: 0.
	world copyBreed: SBreedId turtlesBreedNo var: v1 to: v2.
	self assert: (t var: v1 at: 1) equals: 123.
	self assert: (t var: v2 at: 1) equals: 123
]

{ #category : #test }
SMicroWorldTest >> testCountAliveOf [

	| world r |
	world := self newWorld.
	r := world countAliveOf: SBreedId observerBreedNo.
	self assert: r equals: 1.
	r := world countAliveOf: SBreedId patchesBreedNo.
	self assert: r equals: 10000.
	r := world countAliveOf: SBreedId turtlesBreedNo.
	self assert: r equals: 0.
	world create: SBreedId turtlesBreedNo turtles: 5.
	r := world countAliveOf: SBreedId turtlesBreedNo.
	self assert: r equals: 5
]

{ #category : #test }
SMicroWorldTest >> testCountAliveOfBreedNo [
	| w |
	w := self newWorld.
	w create: 3 turtles: 10.
	w addNewTurtle.
	w create: 4 turtles: 15.
	self assert: (w countAliveOf: 3) equals: 10.
	self assert: (w countAliveOf: 4) equals: 15.
	w createPatch: 10.
	self assert: (w countAliveOf: 2) equals: 100.
]

{ #category : #test }
SMicroWorldTest >> testCreatePatch [

	| world r |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 5.
	r := world countAliveOf: SBreedId patchesBreedNo.
	self assert: r equals: 10000.
	r := world countAliveOf: SBreedId turtlesBreedNo.
	self assert: r equals: 5.
	world createPatch: 5.
	r := world countAliveOf: SBreedId patchesBreedNo.
	self assert: r equals: 25.
	r := world countAliveOf: SBreedId turtlesBreedNo.
	self assert: r equals: 0
]

{ #category : #test }
SMicroWorldTest >> testCreateTurtles [

	| world r |
	world := self newWorld.
	r := world countAliveOf: SBreedId turtlesBreedNo.
	self assert: r equals: 0.
	world create: SBreedId turtlesBreedNo turtles: 5.
	r := world countAliveOf: SBreedId turtlesBreedNo.
	self assert: r equals: 5
]

{ #category : #test }
SMicroWorldTest >> testDeleteBreed [

	| world t |
	world := self newWorld.
	t := world breedOf: SBreedId turtlesBreedNo.
	self assert: t notNil.
	world deleteBreed: t.
	self assert: (world breedOf: SBreedId turtlesBreedNo) isNil
]

{ #category : #test }
SMicroWorldTest >> testDeltaAt [

	| world r |
	world := self newWorld.
	r := world delta: SBreedId turtlesBreedNo at: 1.
	self assert: r equals: 1 @ 0.
	world create: SBreedId turtlesBreedNo turtles: 1.
	world
		var: STurtlesVarDef headingVarNo
		breed: SBreedId turtlesBreedNo
		at: 1
		put: 90.
	r := world delta: SBreedId turtlesBreedNo at: 1.
	self assert: r closeTo: 0 @ 1
]

{ #category : #test }
SMicroWorldTest >> testDiffuse4VarNo [

	| world p v |
	world := self newWorld.
	world createPatch: 3.
	p := world breedOf: SBreedId patchesBreedNo.
	v := p addVariable: 'a'.
	p var: v at: 5 put: 100.
	self
		assertCollection: (p variables realArrayAt: v)
		equals: #(0 0 0 0 100 0 0 0 0) asFloatArray.
	world diffuse4: 80 varNo: v.
	self
		assertCollection: (p variables realArrayAt: v)
		equals: #(0 20 0 20 20 20 0 20 0) asFloatArray
]

{ #category : #test }
SMicroWorldTest >> testDiffuse8VarNo [

	| world p v |
	world := self newWorld.
	world createPatch: 3.
	p := world breedOf: SBreedId patchesBreedNo.
	v := p addVariable: 'a'.
	p var: v at: 5 put: 100.
	self
		assertCollection: (p variables realArrayAt: v)
		equals: #( 0 0 0 0 100 0 0 0 0 ) asFloatArray.
	world diffuse8: 80 varNo: v.
	self
		assertCollection: (p variables realArrayAt: v)
		equals: #( 10 10 10 10 20 10 10 10 10 ) asFloatArray
]

{ #category : #test }
SMicroWorldTest >> testExtent [
	| w |
	w := self newWorld.
	w createPatch: 10.
	self assert: w extent equals: 10 @ 10.
	w createPatch: 20.
	self assert: w extent equals: 20 @ 20.
]

{ #category : #test }
SMicroWorldTest >> testFlagBreedAt [

	| world |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 2.
	self deny: (world
			 flag: STurtlesVarDef penDownFlagNo
			 breed: SBreedId turtlesBreedNo
			 at: 1).
	self deny: (world
			 flag: STurtlesVarDef penDownFlagNo
			 breed: SBreedId turtlesBreedNo
			 at: 2).
	world
		flag: STurtlesVarDef penDownFlagNo
		breed: SBreedId turtlesBreedNo
		at: 1
		put: true.
	world
		flag: STurtlesVarDef penDownFlagNo
		breed: SBreedId turtlesBreedNo
		at: 2
		put: false.
	self assert: (world
			 flag: STurtlesVarDef penDownFlagNo
			 breed: SBreedId turtlesBreedNo
			 at: 1).
	self deny: (world
			 flag: STurtlesVarDef penDownFlagNo
			 breed: SBreedId turtlesBreedNo
			 at: 2)
]

{ #category : #test }
SMicroWorldTest >> testFlagBreedAtPut [

	self testFlagBreedAt
]

{ #category : #test }
SMicroWorldTest >> testForwardBreedId [
	| w |
	w := self newWorld.
	w createPatch: 100.
	w create: 3 turtles: 1.
	(w breedOf: 3) headingAt: 1 put: 0.
	w x: 3 at: 1 put: 49.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1)
		closeTo: -50.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 49.1.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.9.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 49.9.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.1.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 50.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	(w breedOf: 3) headingAt: 1 put: 90.
	w x: 3 at: 1 put: 49.
	w y: 3 at: 1 put: 49.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1)
		closeTo: -50.
	w y: 3 at: 1 put: 49.1.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1)
		closeTo: -49.9.
	w y: 3 at: 1 put: 49.9.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1)
		closeTo: -49.1.
	w y: 3 at: 1 put: 50.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1)
		closeTo: -49
]

{ #category : #test }
SMicroWorldTest >> testHatchId [

	| world v |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addVariable: 'abc'.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		at: 1
		put: 123.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		at: 2
		put: 0.
	self assert: (world countAliveOf: SBreedId turtlesBreedNo) equals: 1.
	world hatch: SBreedId turtlesBreedNo id: 1.
	self assert: (world countAliveOf: SBreedId turtlesBreedNo) equals: 2.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		at: 1
		put: 123.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		at: 2
		put: 123
]

{ #category : #test }
SMicroWorldTest >> testIncrementTicks [

	| world |
	world := self newWorld.
	world observer ticks: 123.
	self assert: world observer ticks equals: 123.
	world incrementTicks.
	self assert: world observer ticks equals: 124
]

{ #category : #test }
SMicroWorldTest >> testInitialize [

	| world |
	world := SMicroWorld new.
	self assert: (world random isKindOf: Random).
	self assert: world raisedEvents isEmpty.
	self assert: world breeds isEmpty.
	self assert: world plotList isEmpty
]

{ #category : #test }
SMicroWorldTest >> testIsPluginWorld [
	self deny: SMicroWorld new isPluginWorld
]

{ #category : #test }
SMicroWorldTest >> testLivingBreedDo [

	| world v |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 5.
	v := (world breedOf: SBreedId turtlesBreedNo) addVariable: 'abc'.
	1 to: 5 do: [ :each | 
		self
			assert: (world var: v breed: SBreedId turtlesBreedNo at: each)
			equals: 0 ].
	world livingBreed: SBreedId turtlesBreedNo do: [ :each | 
		world
			var: v
			breed: SBreedId turtlesBreedNo
			at: each
			put: each ].
	1 to: 5 do: [ :each | 
		self
			assert: (world var: v breed: SBreedId turtlesBreedNo at: each)
			equals: each ]
]

{ #category : #test }
SMicroWorldTest >> testMaxBreedNo [
	| w |
	w := self newWorld.
	self assert: w maxBreedNo equals: 3.
	5 timesRepeat: [ w addNewTurtle ].
	self assert: w maxBreedNo equals: 8
]

{ #category : #test }
SMicroWorldTest >> testMultiplyBreedVarBy [

	| world v |
	world := self newWorld.
	world createPatch: 2.
	v := world patches addVariable: 'abc'.
	world
		var: v
		breed: SBreedId patchesBreedNo
		at: 1
		put: 2.
	world
		var: v
		breed: SBreedId patchesBreedNo
		at: 2
		put: 3.
	self
		assert: (world var: v breed: SBreedId patchesBreedNo at: 1)
		equals: 2.
	self
		assert: (world var: v breed: SBreedId patchesBreedNo at: 2)
		equals: 3.
	world multiplyBreed: SBreedId patchesBreedNo var: v by: 5.
	self
		assert: (world var: v breed: SBreedId patchesBreedNo at: 1)
		equals: 10.
	self
		assert: (world var: v breed: SBreedId patchesBreedNo at: 2)
		equals: 15
]

{ #category : #test }
SMicroWorldTest >> testNewProcess [

	| world obj |
	world := self newWorld.
	obj := world newProcess.
	self assert: (obj isKindOf: SteloNativeProcess).
	self assert: obj sworld identicalTo: world
]

{ #category : #test }
SMicroWorldTest >> testNsum4To [

	| world ps v1 v2 |
	world := self newWorld.
	world createPatch: 3.
	ps := world patches.
	v1 := ps addVariable: 'a'.
	v2 := ps addVariable: 'b'.
	ps var: v1 at: 2 put: 2.
	ps var: v1 at: 7 put: 1.
	self
		assertCollection: (ps variables realArrayAt: v1)
		equals: #( 0 2 0 0 0 0 1 0 0 ) asFloatArray.
	world nsum4: v1 to: v2.
	self
		assertCollection: (ps variables realArrayAt: v2)
		equals: #( 3 0 2 1 2 0 0 3 1 ) asFloatArray
]

{ #category : #test }
SMicroWorldTest >> testNsum8To [

	| world ps v1 v2 |
	world := self newWorld.
	world createPatch: 3.
	ps := world patches.
	v1 := ps addVariable: 'a'.
	v2 := ps addVariable: 'b'.
	"
0 2 0    3 1 3
0 0 0 -> 3 3 3
1 0 0    2 3 3
"
	ps var: v1 at: 2 put: 2.
	ps var: v1 at: 7 put: 1.
	self
		assertCollection: (ps variables realArrayAt: v1)
		equals: #(0 2 0 0 0 0 1 0 0) asFloatArray.
	world nsum8: v1 to: v2.
	self
		assertCollection: (ps variables realArrayAt: v2)
		equals: #(3 1 3 3 3 3 2 3 3) asFloatArray
]

{ #category : #test }
SMicroWorldTest >> testObserver [
	| w |
	w := self newWorld.
	self assert: w observer class equals: SObserver.
]

{ #category : #test }
SMicroWorldTest >> testPatchIndexAtXY [

	| world ps |
	world := self newWorld.
	world createPatch: 5.
	ps := world patches.
	self assert: (ps indexAtX: -2 y: -2) equals: 1.
	self assert: (ps indexAtX: -1 y: -2) equals: 2.
	self assert: (ps indexAtX: 0 y: -2) equals: 3.
	self assert: (ps indexAtX: 1 y: -2) equals: 4.
	self assert: (ps indexAtX: 2 y: -2) equals: 5.
	self assert: (ps indexAtX: -3 y: -2) equals: 5.
	self assert: (ps indexAtX: -2 y: -1) equals: 6.
	self assert: (ps indexAtX: -2 y: 0) equals: 11.
	self assert: (ps indexAtX: -2 y: 1) equals: 16.
	self assert: (ps indexAtX: -2 y: 2) equals: 21.
	self assert: (ps indexAtX: -2 y: -3) equals: 21
]

{ #category : #test }
SMicroWorldTest >> testPatches [
	| w |
	w := self newWorld.
	self assert: w patches class equals: SPatches.
]

{ #category : #test }
SMicroWorldTest >> testPlotColor [
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w plot: 1 color: ColorList red.
	w plot: 3 color: ColorList blue.
	ret := w plotList.
	self assert: ret size equals: 2.
	self assertCollection: ret first channel equals: 1.
	self assertCollection: ret first color equals: Color red.
	self assertCollection: ret second channel equals: 3.
	self assertCollection: ret second color equals: Color blue.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
]

{ #category : #test }
SMicroWorldTest >> testPlotData [
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w plot: 1 data: 2.
	w plot: 3 data: 4.
	ret := w plotList.
	self assert: ret size equals: 2.
	self assertCollection: ret first channel equals: 1.
	self assertCollection: ret first data equals: 2.
	self assertCollection: ret second channel equals: 3.
	self assertCollection: ret second data equals: 4.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty
]

{ #category : #test }
SMicroWorldTest >> testPlotList [
	| w ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isEmpty.
	w plotList: #(1 2 3).
	ret := w plotList.
	self assertCollection: ret equals: #(1 2 3).
	ret := w plotList.
	self assert: ret isEmpty
]

{ #category : #test }
SMicroWorldTest >> testPrintOn [

	| world stream |
	world := self newWorld.
	stream := WriteStream on: String new.
	world printOn: stream.
	self assert: (stream contents beginsWith: 'MicroWorld')
]

{ #category : #test }
SMicroWorldTest >> testRaiseEvent [
	| w |
	w := SMicroWorld new.
	self assert: w raisedEvents isEmpty.
	w raiseEvent: #a.
	self assertCollection: w raisedEvents asArray equals: #(a).
	w raiseEvent: #b.
	self assert: w raisedEvents size equals: 2.
	self assert: (w raisedEvents includes: #a).
	self assert: (w raisedEvents includes: #b).
]

{ #category : #test }
SMicroWorldTest >> testRaisedEvents [
	| w |
	w := SMicroWorld new.
	self assert: w raisedEvents isEmpty.
	w raiseEvent: #a.
	self assertCollection: w raisedEvents asArray equals: #(a).
	w raiseEvent: #b.
	self assert: w raisedEvents size equals: 2.
	self assert: (w raisedEvents includes: #a).
	self assert: (w raisedEvents includes: #b).
]

{ #category : #test }
SMicroWorldTest >> testRandom [
	| w |
	w := self newWorld.
	self assert: w random identicalTo: SharedRandom globalGenerator
]

{ #category : #test }
SMicroWorldTest >> testRandomFromTo [
	| w a b r |
	w := self newWorld.
	self assert: (w random isKindOf: SharedRandom).
	w setRandomSeed: 1234.
	r := Random seed: 1234.
	a := w randomFrom: 1 to: 10.
	b := (1 to: 10) atRandom: r.
	self assert: a equals: b.
	a := w randomFrom: 1 to: 10.
	b := (1 to: 10) atRandom: r.
	self assert: a equals: b
]

{ #category : #test }
SMicroWorldTest >> testReset [

	| world |
	world := self newWorld.
	world raiseEvent: 1.
	world plot: 1 data: 2.
	self assert: world raisedEvents notEmpty.
	self assert: world breeds notEmpty.
	self assert: world plotList notEmpty.
	world reset.
	self assert: world raisedEvents isEmpty.
	self assert: world breeds isEmpty.
	self assert: world plotList isEmpty
]

{ #category : #test }
SMicroWorldTest >> testScaleVarColorBreedFromToId [

	| world v |
	world := self newWorld.
	world createPatch: 2.
	v := (world breedOf: SBreedId patchesBreedNo) addVariable: 'abc'.
	world
		var: v
		breed: SBreedId patchesBreedNo
		at: 1
		put: 10.
	world
		var: v
		breed: SBreedId patchesBreedNo
		at: 2
		put: 5.
	world
		var: v
		breed: SBreedId patchesBreedNo
		at: 3
		put: 1.
	world
		var: v
		breed: SBreedId patchesBreedNo
		at: 4
		put: 9.
	world
		scaleVar: v
		color: 35
		breed: SBreedId patchesBreedNo
		from: 1
		to: 9
		id: 1.
	self
		assert: (world
				 var: SPatchesVarDef colorVarNo
				 breed: SBreedId patchesBreedNo
				 at: 1)
		equals: ColorList white.
	self
		assert: (world
				 var: SPatchesVarDef colorVarNo
				 breed: SBreedId patchesBreedNo
				 at: 2)
		equals: 0.
	self
		assert: (world
				 var: SPatchesVarDef colorVarNo
				 breed: SBreedId patchesBreedNo
				 at: 3)
		equals: 0.
	self
		assert: (world
				 var: SPatchesVarDef colorVarNo
				 breed: SBreedId patchesBreedNo
				 at: 4)
		equals: 0.
	world
		scaleVar: v
		color: 35
		breed: SBreedId observerBreedNo
		from: 1
		to: 9
		id: 1.
	self
		assert: (world
				 var: SPatchesVarDef colorVarNo
				 breed: SBreedId patchesBreedNo
				 at: 1)
		equals: ColorList white.
	self
		assert: (world
				 var: SPatchesVarDef colorVarNo
				 breed: SBreedId patchesBreedNo
				 at: 2)
		equals: 34.
	self
		assert: (world
				 var: SPatchesVarDef colorVarNo
				 breed: SBreedId patchesBreedNo
				 at: 3)
		equals: 30.
	self
		assert: (world
				 var: SPatchesVarDef colorVarNo
				 breed: SBreedId patchesBreedNo
				 at: 4)
		equals: 39
]

{ #category : #test }
SMicroWorldTest >> testSetPlotYMax [

	| world list |
	world := self newWorld.
	self assert: world plotList isEmpty.
	world setPlotYMax: 123.
	list := world plotList.
	self assert: list size equals: 1.
	self assert: list first isSetPlotYMax.
	self assert: list first args first equals: 123
]

{ #category : #test }
SMicroWorldTest >> testSetPlotYMin [

	| world list |
	world := self newWorld.
	self assert: world plotList isEmpty.
	world setPlotYMin: 123.
	list := world plotList.
	self assert: list size equals: 1.
	self assert: list first isSetPlotYMin.
	self assert: list first args first equals: 123
]

{ #category : #test }
SMicroWorldTest >> testSetRandomSeed [
	| w a b r |
	w := self newWorld.
	self assert: w random identicalTo: SharedRandom globalGenerator.
	w setRandomSeed: 1234.
	self deny: (w random isKindOf: SharedRandom).
	self assert: (w random isKindOf: Random).
	r := Random seed: 1234.
	a := (1 to: 10) atRandom: r.
	b := (1 to: 10) atRandom: w random.
	self assert: a equals: b.
	a := (1 to: 10) atRandom: r.
	b := (1 to: 10) atRandom: w random.
	self assert: a equals: b.
	w setRandomSeed: 0.
	self assert: w random identicalTo: SharedRandom globalGenerator
]

{ #category : #test }
SMicroWorldTest >> testSizeOf [

	| world |
	world := self newWorld.
	self assert: (world sizeOf: SBreedId observerBreedNo) equals: 1.
	self assert: (world sizeOf: SBreedId patchesBreedNo) equals: 10000.
	self assert: (world sizeOf: SBreedId turtlesBreedNo) equals: 0.
	world createPatch: 5.
	world create: SBreedId turtlesBreedNo turtles: 1.
	self assert: (world sizeOf: SBreedId patchesBreedNo) equals: 25.
	self assert: (world sizeOf: SBreedId turtlesBreedNo) equals: 100
]

{ #category : #test }
SMicroWorldTest >> testTurtleBreedsDo [

	| world count |
	world := self newWorld.
	world addNewTurtle.
	count := 0.
	world turtleBreedsDo: [ :each | 
		self assert: (each isKindOf: STurtles).
		count := count + 1 ].
	self assert: count equals: 2
]

{ #category : #test }
SMicroWorldTest >> testTurtlesAt [

	| world r p |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 5.
	world x: SBreedId turtlesBreedNo at: 1 put: 1.
	world y: SBreedId turtlesBreedNo at: 1 put: 1.
	world x: SBreedId turtlesBreedNo at: 2 put: 1.
	world y: SBreedId turtlesBreedNo at: 2 put: 2.
	world x: SBreedId turtlesBreedNo at: 3 put: 3.
	world y: SBreedId turtlesBreedNo at: 3 put: 4.
	world x: SBreedId turtlesBreedNo at: 4 put: 1.
	world y: SBreedId turtlesBreedNo at: 4 put: 2.
	world x: SBreedId turtlesBreedNo at: 5 put: 5.
	world y: SBreedId turtlesBreedNo at: 5 put: 6.
	p := world patchIndexAtX: 1 y: 2.
	r := world turtles: SBreedId turtlesBreedNo at: p.
	self assertCollection: r hasSameElements: #( 2 4 )
]

{ #category : #test }
SMicroWorldTest >> testTurtlesDo [

	| world count |
	world := self newWorld.
	world addNewTurtle.
	world create: SBreedId turtlesBreedNo turtles: 2.
	world create: SBreedId turtlesBreedNo + 1 turtles: 3.
	count := 0.
	world turtlesDo: [ :each :breed | 
		count := count + 1.
		self assert: (breed isKindOf: STurtles) ].
	self assert: count equals: 5
]

{ #category : #test }
SMicroWorldTest >> testVarBreedAt [

	| world v |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 3.
	v := (world breedOf: SBreedId turtlesBreedNo) addVariable: 'abc'.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		at: 1
		put: 11.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		at: 2
		put: 22.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		at: 3
		put: 33.
	self
		assert: (world var: v breed: SBreedId turtlesBreedNo at: 1)
		equals: 11.
	self
		assert: (world var: v breed: SBreedId turtlesBreedNo at: 2)
		equals: 22.
	self
		assert: (world var: v breed: SBreedId turtlesBreedNo at: 3)
		equals: 33
]

{ #category : #test }
SMicroWorldTest >> testVarBreedAtPut [

	self testVarBreedAt
]

{ #category : #test }
SMicroWorldTest >> testVarBreedList [

	| world v r |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addList: 'abc'.
	r := world var: v breed: SBreedId turtlesBreedNo list: 1.
	self assert: r isEmpty.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 123.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 456.
	r := world var: v breed: SBreedId turtlesBreedNo list: 1.
	self assertCollection: r hasSameElements: #( 123 456 )
]

{ #category : #test }
SMicroWorldTest >> testVarBreedListAdd [

	self testVarBreedList
]

{ #category : #test }
SMicroWorldTest >> testVarBreedListAt [

	| world v r |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addList: 'abc'.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 123.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 456.
	r := world var: v breed: SBreedId turtlesBreedNo list: 1 at: 1.
	self assert: r equals: 123.
	r := world var: v breed: SBreedId turtlesBreedNo list: 1 at: 2.
	self assert: r equals: 456
]

{ #category : #test }
SMicroWorldTest >> testVarBreedListAtPut [

	| world v r |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addList: 'abc'.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 123.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 456.
	r := world
		     var: v
		     breed: SBreedId turtlesBreedNo
		     list: 1
		     at: 1.
	self assert: r equals: 123.
	r := world
		     var: v
		     breed: SBreedId turtlesBreedNo
		     list: 1
		     at: 2.
	self assert: r equals: 456.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		at: 1
		put: 987.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		at: 2
		put: 654.
	r := world
		     var: v
		     breed: SBreedId turtlesBreedNo
		     list: 1
		     at: 1.
	self assert: r equals: 987.
	r := world
		     var: v
		     breed: SBreedId turtlesBreedNo
		     list: 1
		     at: 2.
	self assert: r equals: 654
]

{ #category : #test }
SMicroWorldTest >> testVarBreedListContains [

	| world v |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addList: 'abc'.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 123.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 456.
	self assert: (world
			 var: v
			 breed: SBreedId turtlesBreedNo
			 list: 1
			 contains: 123).
	self assert: (world
			 var: v
			 breed: SBreedId turtlesBreedNo
			 list: 1
			 contains: 456).
	self deny: (world
			 var: v
			 breed: SBreedId turtlesBreedNo
			 list: 1
			 contains: 789)
]

{ #category : #test }
SMicroWorldTest >> testVarBreedListRemove [

	| world v r |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addList: 'abc'.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 123.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 456.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 789.
	r := world var: v breed: SBreedId turtlesBreedNo list: 1.
	self assertCollection: r hasSameElements: #( 123 456 789 ).
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		remove: 2.
	r := world var: v breed: SBreedId turtlesBreedNo list: 1.
	self assertCollection: r hasSameElements: #( 123 789 )
]

{ #category : #test }
SMicroWorldTest >> testVarBreedListSet [

	| world v a r |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addList: 'abc'.
	a := #( 123 456 789 ).
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		set: a.
	r := world var: v breed: SBreedId turtlesBreedNo list: 1.
	self assertCollection: r hasSameElements: #( 123 456 789 ).
	self deny: r identicalTo: a
]

{ #category : #test }
SMicroWorldTest >> testVarBreedListSizeOf [

	| world v r |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 1.
	v := (world breedOf: SBreedId turtlesBreedNo) addList: 'abc'.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 123.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 456.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		add: 789.
	r := world var: v breed: SBreedId turtlesBreedNo listSizeOf: 1.
	self assert: r equals: 3.
	world
		var: v
		breed: SBreedId turtlesBreedNo
		list: 1
		remove: 2.
	r := world var: v breed: SBreedId turtlesBreedNo listSizeOf: 1.
	self assert: r equals: 2
]

{ #category : #test }
SMicroWorldTest >> testWorldName [

	self assert: self newWorld worldName equals: 'MicroWorld'
]

{ #category : #test }
SMicroWorldTest >> testXAt [

	| world |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 2.
	world x: SBreedId turtlesBreedNo at: 1 put: 123.
	world x: SBreedId turtlesBreedNo at: 2 put: 34.
	self assert: (world x: SBreedId turtlesBreedNo at: 1) equals: 23.
	self assert: (world x: SBreedId turtlesBreedNo at: 2) equals: 34
]

{ #category : #test }
SMicroWorldTest >> testXAtPut [

	self testXAt
]

{ #category : #test }
SMicroWorldTest >> testYAt [

	| world |
	world := self newWorld.
	world create: SBreedId turtlesBreedNo turtles: 2.
	world y: SBreedId turtlesBreedNo at: 1 put: 123.
	world y: SBreedId turtlesBreedNo at: 2 put: 34.
	self assert: (world y: SBreedId turtlesBreedNo at: 1) equals: 23.
	self assert: (world y: SBreedId turtlesBreedNo at: 2) equals: 34
]

{ #category : #test }
SMicroWorldTest >> testYAtPut [

	self testYAt
]
