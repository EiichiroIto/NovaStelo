"
A SEngineTest is a test class for testing the behavior of SEngine
"
Class {
	#name : #SteloNativeThreadTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloNativeThreadTest >> newThread [
	^ SteloNativeThread sworld: SMicroWorld new
]

{ #category : #private }
SteloNativeThreadTest >> newThread: aWorld [
	^ SteloNativeThread sworld: aWorld
]

{ #category : #private }
SteloNativeThreadTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	w addBreed: SPatches new.
	w newBreed.
	^ w
]

{ #category : #private }
SteloNativeThreadTest >> sampleCode1 [
	^ OrderedCollection new
		add: #pushShort;
		add: 3;
		add: 0;
		add: #forward;
		add: #stop;
		yourself
]

{ #category : #private }
SteloNativeThreadTest >> sampleCode2 [
	^ #(pushShort 1 0 pushShort 2 0 plus return pushShort 1 0 call returnValue dup mul stop)
]

{ #category : #test }
SteloNativeThreadTest >> testAbs [
	| t |
	t := self newThread.
	t push: 10.
	self assert: t stack size equals: 1.
	t abs.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 10.
	t push: -20.
	self assert: t stack size equals: 1.
	t abs.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testAcos [
	| t |
	t := self newThread.
	t push: 0.5.
	self assert: t stack size equals: 1.
	t acos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 60.
	t push: -10.
	self assert: t stack size equals: 1.
	t acos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 180.
]

{ #category : #test }
SteloNativeThreadTest >> testAimHigh [
	| w v t |
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
		var: STurtleVarDef headingVarNo
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
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t push: v.
	t aimHigh.
	self assert: t pop equals: -45
]

{ #category : #test }
SteloNativeThreadTest >> testAnd [
	| t |
	t := self newThread.
	t push: false.
	t push: false.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: false.
	t push: true.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: true.
	t push: false.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: true.
	t push: true.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #test }
SteloNativeThreadTest >> testAppendToList [
	| w t v |
	w := self newWorld.
	t := self newThread: w.
	w create: SBreedId turtleBreedNo turtles: 1.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	t push: v.
	t push: 123.
	t appendToList.
	t push: v.
	t push: 456.
	t appendToList.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 1) equals: 123.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 2) equals: 456.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testAsin [
	| t |
	t := self newThread.
	t push: 0.5.
	self assert: t stack size equals: 1.
	t asin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 30.
	t push: -10.
	self assert: t stack size equals: 1.
	t asin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -90.
]

{ #category : #test }
SteloNativeThreadTest >> testAtan [
	| t |
	t := self newThread.
	t push: 1.
	self assert: t stack size equals: 1.
	t atan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 45.
	t push: -10.
	self assert: t stack size equals: 1.
	t atan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -45.
]

{ #category : #test }
SteloNativeThreadTest >> testBroadcast [
	| w e s |
	w := self newWorld.
	e := self newThread: w.
	s := e stack size.
	e push: 10.
	self assert: w raisedEvents isEmpty.
	e broadcast.
	self assert: e stack size equals: s.
	self assert: w raisedEvents size equals: 1.
	self assert: (w raisedEvents includes: 10).
]

{ #category : #test }
SteloNativeThreadTest >> testCall [
	| e |
	e := self newThread.
	e pc: 20.
	e push: 10.
	e call.
	self assert: e pc equals: 10.
	self assert: e stack size equals: 1.
	self assert: e pop equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testClearBreed [
	| w e |
	w := self newWorld.
	w create: 3 turtles: 5.
	w addBreed: (STurtles new breedNo: 4).
	w create: 4 turtles: 10.
	e := self newThread: w.
	self assert: (w breedOf: 3) countAlive equals: 5.
	self assert: (w breedOf: 4) countAlive equals: 10.
	e push: 3.
	e clearBreed.
	self assert: (w breedOf: 3) countAlive equals: 0.
	self assert: (w breedOf: 4) countAlive equals: 10.
	self assert: e stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testClearList [
	| w t v |
	w := self newWorld.
	w create: SBreedId turtleBreedNo turtles: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 10.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 20.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 30.
	t := self newThread: w.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	t push: v.
	t clearList.
	self assert: t stack size equals: 0.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1) isEmpty
]

{ #category : #test }
SteloNativeThreadTest >> testClearTurtles [
	| w e s |
	w := self newWorld.
	w create: 3 turtles: 5.
	w addBreed: (STurtles new breedNo: 4).
	w create: 4 turtles: 10.
	e := self newThread: w.
	s := e stack size.
	self assert: (w breedOf: 3) countAlive equals: 5.
	self assert: (w breedOf: 4) countAlive equals: 10.
	e clearTurtles.
	self assert: (w breedOf: 3) countAlive equals: 0.
	self assert: (w breedOf: 4) countAlive equals: 0.
	self assert: e stack size equals: s.
]

{ #category : #test }
SteloNativeThreadTest >> testCodes [
	| t |
	t := self newThread.
	self assert: t codes isNil.
	t codes: #(1 2 3).
	self assertCollection: t codes equals: #(1 2 3).
]

{ #category : #test }
SteloNativeThreadTest >> testCos [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t cos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 90.
	self assert: t stack size equals: 1.
	t cos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 180.
	self assert: t stack size equals: 1.
	t cos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.
	t push: 270.
	self assert: t stack size equals: 1.
	t cos.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testCreatePatch [
	| w e |
	w := self newWorld.
	e := self newThread: w.
	self assert: w patches rows equals: 100.
	self assert: w patches cols equals: 100.
	self assert: e stack size equals: 0.
	e push: 20.
	e createPatch.
	self assert: e stack size equals: 0.
	self assert: w patches rows equals: 20.
	self assert: w patches cols equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testCreateTurtles [
	| w e s |
	w := self newWorld.
	e := self newThread: w.
	s := e stack size.
	e push: 20.
	e push: 3.
	self assert: (w breedOf: 3) countAlive equals: 0.
	e createTurtles.
	self assert: e stack size equals: s.
	self assert: (w breedOf: 3) countAlive equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testDec [
	| t |
	t := self newThread.
	t push: 10.
	self assert: t stack first equals: 10.
	t dec.
	self assert: t stack first equals: 9.
	t dec.
	self assert: t stack first equals: 8.
]

{ #category : #test }
SteloNativeThreadTest >> testDeleteLineOfList [
	| w t v |
	w := self newWorld.
	w create: SBreedId turtleBreedNo turtles: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 10.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 20.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 30.
	t := self newThread: w.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	t push: v.
	t push: 2.
	t deleteLineOfList.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 1) equals: 10.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 2) equals: 30.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testDirection [
	| t |
	t := self newThread.
	t forPatchId: 1.
	t push: 0.
	t push: 0.
	t direction.
	self assert: t pop equals: 90.
	t push: 1.
	t push: 1.
	t direction.
	self assert: t pop equals: 45.
	t push: 0.
	t push: 1.
	t direction.
	self assert: t pop equals: 90.
	t push: 0.
	t push: -1.
	t direction.
	self assert: t pop equals: -90.
	t push: -1.
	t push: 1.
	t direction.
	self assert: t pop equals: 135.
	t push: -1.
	t push: -1.
	t direction.
	self assert: t pop equals: 225.
	t push: 1.
	t push: -1.
	t direction.
	self assert: t pop equals: 360 - 45.
]

{ #category : #test }
SteloNativeThreadTest >> testDiv [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t div.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 2.
	t push: 5.
	t push: -10.
	self assert: t stack size equals: 2.
	t div.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -0.5.
	self deny: t isTerminated.
	t push: 5.
	t push: 0.
	t div.
	self assert: t isTerminated.
]

{ #category : #test }
SteloNativeThreadTest >> testDoOneCycle [
	| e w c |
	w := self newWorld.
	w create: 3 turtles: 1.
	w x: 3 at: 1 put: 0.
	w y: 3 at: 1 put: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 0.
	c := self sampleCode1.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e codes: c.
	self assert: e pc equals: 1.
	self assert: e stack isEmpty.
	self assert: e doOneCycle not.
	self assert: e pc equals: c size + 1.
	self assert: e stack isEmpty.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 3.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 0.
	self should: [e doOneCycle] raise: Error.
]

{ #category : #test }
SteloNativeThreadTest >> testDrop [
	| t |
	t := self newThread.
	self assert: t stack size equals: 0.
	t push: 10.
	self assert: t stack size equals: 1.
	t drop.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testDup [
	| t |
	t := self newThread.
	self assert: t stack size equals: 0.
	t push: 10.
	self assert: t stack size equals: 1.
	t dup.
	self assert: t stack size equals: 2.
	self assert: t pop equals: 10.
	self assert: t pop equals: 10.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testDx [
	| e w |
	w := self newWorld.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 0.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dx.
	self assert: e pop closeTo: 1.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 90.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dx.
	self assert: e pop closeTo: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 180.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dx.
	self assert: e pop closeTo: -1.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 270.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dx.
	self assert: e pop closeTo: 0
]

{ #category : #test }
SteloNativeThreadTest >> testDy [
	| e w |
	w := self newWorld.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 0.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dy.
	self assert: e pop closeTo: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 90.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dy.
	self assert: e pop closeTo: 1.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 180.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dy.
	self assert: e pop closeTo: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 270.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dy.
	self assert: e pop closeTo: -1
]

{ #category : #test }
SteloNativeThreadTest >> testEqual [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t equal.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: -10.
	self assert: t stack size equals: 2.
	t equal.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #test }
SteloNativeThreadTest >> testErrorOccuered [
	| t |
	t := self newThread.
	self assert: t isTerminated equals: false.
	t errorOccuered.
	self assert: t isTerminated equals: true.
]

{ #category : #test }
SteloNativeThreadTest >> testEvaluate [
	| w t c x |
	w := self newWorld.
	t := self newThread: w.
	w create: 3 turtles: 1.
	w var: STurtleVarDef colorVarNo breed: 3 at: 1 put: SColorList black.
	c := #(push1 pushShort 2 0 #plus #stop).
	t forBreedNo: 3 index: 1.
	t codes: c.
	x := t evaluate: 1.
	self assert: x equals: 3.
]

{ #category : #test }
SteloNativeThreadTest >> testExecute [
	| w t c x |
	w := self newWorld.
	t := self newThread: w.
	w create: 3 turtles: 1.
	w var: STurtleVarDef colorVarNo breed: 3 at: 1 put: SColorList black.
	c := {#pushShort. SColorList white. 0. #setColorTo. #stop}.
	t forBreedNo: 3 index: 1.
	t codes: c.
	t execute: 1.
	x := w var: STurtleVarDef colorVarNo breed: 3 at: 1.
	self assert: x equals: SColorList white.
]

{ #category : #test }
SteloNativeThreadTest >> testExp [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 2.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2 exp.
	t push: -1.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1 / 1 exp.
]

{ #category : #test }
SteloNativeThreadTest >> testExp10 [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 2.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 100.
	t push: -1.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.1.
]

{ #category : #test }
SteloNativeThreadTest >> testForBreedNoIndex [
	| e |
	e := self newThread.
	self assert: e privBreedId isNil.
	self assert: e privId isNil.
	e forBreedNo: 3 index: 123.
	self assert: e privBreedId equals: 3.
	self assert: e privId equals: 123.
]

{ #category : #test }
SteloNativeThreadTest >> testForObserver [
	| e |
	e := self newThread.
	self assert: e privBreedId isNil.
	self assert: e privId isNil.
	e forObserver.
	self assert: e privBreedId equals: SBreedId observerBreedNo.
	self assert: e privId equals: 1.
]

{ #category : #test }
SteloNativeThreadTest >> testForPatchId [
	| e |
	e := self newThread.
	self assert: e privBreedId isNil.
	self assert: e privId isNil.
	e forPatchId: 123.
	self assert: e privBreedId equals: 2.
	self assert: e privId equals: 123.
]

{ #category : #test }
SteloNativeThreadTest >> testForward [
	| e w |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 1.
	w x: 3 at: 1 put: 0.
	w y: 3 at: 1 put: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 0.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e push: 1.
	e forward.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) closeTo: 1.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	e push: 2.
	e forward.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -2.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0
]

{ #category : #test }
SteloNativeThreadTest >> testGetBreedId [
	| w t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.

	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t getBreedId.
	self assert: t pop equals: 3.

	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t getBreedId.
	self assert: t pop equals: 3.

	t := self newThread: w.
	t forPatchId: 3.
	t getBreedId.
	self assert: t pop equals: 2.

	t := self newThread: w.
	t forObserver.
	t getBreedId.
	self assert: t pop equals: 1.
]

{ #category : #test }
SteloNativeThreadTest >> testGetBreedVar [
	| w t v |
	w := self newWorld.
	t := self newThread: w.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	t push: 1.
	t push: v.
	t push: SBreedId patchBreedNo.
	t getBreedVar.
	self assert: t pop equals: 0.
	w patches privVariables var: v at: 1 put: 2.
	t push: 1.
	t push: v.
	t push: SBreedId patchBreedNo.
	t getBreedVar.
	self assert: t pop equals: 2
]

{ #category : #test }
SteloNativeThreadTest >> testGetId [
	| t |
	t := self newThread.
	t privId: 10.
	self assert: t stack size equals: 0.
	t getId.
	self assert: t pop equals: 10.
]

{ #category : #test }
SteloNativeThreadTest >> testGetLineOfList [
	| w t v |
	w := self newWorld.
	w create: SBreedId turtleBreedNo turtles: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 10.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 20.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 30.
	t := self newThread: w.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	t push: v.
	t push: 2.
	t getLineOfList.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 20
]

{ #category : #test }
SteloNativeThreadTest >> testGetVar [
	| w t v |
	w := self newWorld.
	t := self newThread: w.
	w create: 3 turtles: 1.
	t forBreedNo: 3 index: 1.
	v := (w breedOf: 3) addVariable: 'b'.
	t push: v.
	t getVar.
	self assert: t pop equals: 0.
	w
		var: v
		breed: 3
		at: 1
		put: 10.
	t push: v.
	t getVar.
	self assert: t pop equals: 10
]

{ #category : #test }
SteloNativeThreadTest >> testGetX [
	| w t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 3.
	w x: 3 at: 1 put: 1.
	w x: 3 at: 2 put: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t getX.
	self assert: t pop equals: 1.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t getX.
	self assert: t pop equals: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 3.
	t getX.
	self assert: t pop equals: 0.
	t := self newThread: w.
	t forPatchId: 3.
	t getX.
	self assert: t pop equals: 1
]

{ #category : #test }
SteloNativeThreadTest >> testGetY [
	| w t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 3.
	w y: 3 at: 1 put: 1.
	w y: 3 at: 2 put: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t getY.
	self assert: t pop equals: 1.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t getY.
	self assert: t pop equals: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 3.
	t getY.
	self assert: t pop equals: 0.
	t := self newThread: w.
	t forPatchId: 3.
	t getY.
	self assert: t pop equals: -1
]

{ #category : #test }
SteloNativeThreadTest >> testHatch [
	| w e s |
	w := self newWorld.
	w create: 3 turtles: 1.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	s := e stack size.
	self assert: (w breedOf: 3) countAlive equals: 1.
	self assert: ((w breedOf: 3) aliveAt: 1).
	e hatch.
	self assert: (w breedOf: 3) countAlive equals: 2.
	self assert: ((w breedOf: 3) aliveAt: 1).
	self assert: ((w breedOf: 3) aliveAt: 2).
	self assert: e stack size equals: s.
]

{ #category : #test }
SteloNativeThreadTest >> testInitialize [
	self testPc.
	self testStack.
]

{ #category : #test }
SteloNativeThreadTest >> testInv [
	| t |
	t := self newThread.
	t push: 0.
	t inv.
	self assert: t pop equals: 16rFFFF.
	t := self newThread.
	t push: 16rFFFF.
	t inv.
	self assert: t pop equals: 0.
	t := self newThread.
	t push: 16r1234.
	t inv.
	self assert: t pop equals: 16rEDCB.
]

{ #category : #test }
SteloNativeThreadTest >> testIsRunning [
	self testPrivIsRunning.
]

{ #category : #test }
SteloNativeThreadTest >> testIsTerminated [
	self testPrivIsTerminated.
]

{ #category : #test }
SteloNativeThreadTest >> testJump [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t push: 5.
	self assert: t stack size equals: 1.
	t jump.
	self assert: t pc equals: 5.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testJumpIfFalse [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t push: true.
	t push: 5.
	self assert: t stack size equals: 2.
	t jumpIfFalse.
	self assert: t pc equals: 1.
	self assert: t stack size equals: 0.
	t push: false.
	t push: 5.
	self assert: t stack size equals: 2.
	t jumpIfFalse.
	self assert: t pc equals: 5.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testJumpIfTrue [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t push: false.
	t push: 5.
	self assert: t stack size equals: 2.
	t jumpIfTrue.
	self assert: t pc equals: 1.
	self assert: t stack size equals: 0.
	t push: true.
	t push: 5.
	self assert: t stack size equals: 2.
	t jumpIfTrue.
	self assert: t pc equals: 5.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testKill [
	| w e s |
	w := self newWorld.
	w create: 3 turtles: 2.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e codes: #(1 2 3 4).
	s := e stack size.
	self assert: ((w breedOf: 3) aliveAt: 1).
	e push: 3.
	e push: 1.
	e kill.
	self assert: e stack size equals: s.
	self assert: ((w breedOf: 3) aliveAt: 1) not.
	self deny: e isRunning.
]

{ #category : #test }
SteloNativeThreadTest >> testLess [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t less.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: -10.
	self assert: t stack size equals: 2.
	t less.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: 10.
	self assert: t stack size equals: 2.
	t less.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #test }
SteloNativeThreadTest >> testLessEqual [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: -10.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: -10.
	t push: 10.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #test }
SteloNativeThreadTest >> testLineCountOfList [
	| w t v |
	w := self newWorld.
	w create: SBreedId turtleBreedNo turtles: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 10.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 20.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 30.
	t := self newThread: w.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	t push: v.
	t lineCountOfList.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 3
]

{ #category : #test }
SteloNativeThreadTest >> testListContains [
	| w t v |
	w := self newWorld.
	w create: SBreedId turtleBreedNo turtles: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 10.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 20.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 30.
	t := self newThread: w.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	t push: v.
	t push: 10.
	t listContains.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t := self newThread: w.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	t push: v.
	t push: 40.
	t listContains.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0
]

{ #category : #test }
SteloNativeThreadTest >> testLn [
	| t |
	t := self newThread.
	t push: 1.
	self assert: t stack size equals: 1.
	t ln.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 2 exp.
	self assert: t stack size equals: 1.
	t ln.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2.
	t push: 1 / 1 exp.
	self assert: t stack size equals: 1.
	t ln.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.
]

{ #category : #test }
SteloNativeThreadTest >> testLog [
	| t |
	t := self newThread.
	t push: 1.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 100.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2.
	t push: 0.1.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.
]

{ #category : #test }
SteloNativeThreadTest >> testMinus [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t minus.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 5.
	t push: 5.
	t push: -10.
	self assert: t stack size equals: 2.
	t minus.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 15.
]

{ #category : #test }
SteloNativeThreadTest >> testMod [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t mod.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -5.
	t push: 10.
	self assert: t stack size equals: 2.
	t mod.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 5.
]

{ #category : #test }
SteloNativeThreadTest >> testMul [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t mul.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 50.
	t push: 0.5.
	t push: -10.
	self assert: t stack size equals: 2.
	t mul.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -5.
]

{ #category : #test }
SteloNativeThreadTest >> testNot [
	| t |
	t := self newThread.
	t push: false.
	self assert: t stack size equals: 1.
	t not.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: true.
	self assert: t stack size equals: 1.
	t not.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testOr [
	| t |
	t := self newThread.
	t push: false.
	t push: false.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t stack first equals: 0.
	t pop.
	t push: false.
	t push: true.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: true.
	t push: false.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: true.
	t push: true.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
]

{ #category : #test }
SteloNativeThreadTest >> testPatchAt [
	| w t |
	w := self newWorld.
	t := self newThread: w.
	w createPatch: 4.
	t push: 0.
	t push: 0.
	t patchAt.
	self assert: t pop equals: 11.
	t push: -2.
	t push: -2.
	t patchAt.
	self assert: t pop equals: 1.
	t push: 1.
	t push: 1.
	t patchAt.
	self assert: t pop equals: 16.
	t push: 0.
	t push: -1.
	t patchAt.
	self assert: t pop equals: 7.
]

{ #category : #test }
SteloNativeThreadTest >> testPc [
	| e |
	e := self newThread.
	self assert: e pc equals: 1.
	e pc: 10.
	self assert: e pc equals: 10.
	e pc: 20.
	self assert: e pc equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testPlus [
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t plus.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 15.
	t push: 5.
	t push: -10.
	self assert: t stack size equals: 2.
	t plus.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -5.
]

{ #category : #test }
SteloNativeThreadTest >> testPop [
	| e |
	e := self newThread.
	e push: 10.
	e push: 20.
	self assertCollection: e stack asArray equals: #(10 20).
	self assert: e pop equals: 20.
	self assert: e pop equals: 10.
	self assert: e stack isEmpty.
]

{ #category : #test }
SteloNativeThreadTest >> testPrivBreedId [
	| e |
	e := self newThread.
	self assert: e privBreedId isNil.
	e privBreedId: 10.
	self assert: e privBreedId equals: 10.
	e privBreedId: 20.
	self assert: e privBreedId equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testPrivId [
	| e |
	e := self newThread.
	self assert: e privId isNil.
	e privId: 10.
	self assert: e privId equals: 10.
	e privId: 20.
	self assert: e privId equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testPrivIsRunning [
	| t |
	t := self newThread.
	self assert: t isRunning equals: false.
	t privIsRunning: true.
	self assert: t isRunning equals: true.
	t privIsRunning: false.
	self assert: t isRunning equals: false.
]

{ #category : #test }
SteloNativeThreadTest >> testPrivIsTerminated [
	| t |
	t := self newThread.
	self assert: t isTerminated equals: false.
	t privIsTerminated: true.
	self assert: t isTerminated equals: true.
	t privIsTerminated: false.
	self assert: t isTerminated equals: false.
]

{ #category : #test }
SteloNativeThreadTest >> testPrivRetVal [
	| t |
	t := self newThread.
	self assert: t retVal equals: 0.
	t privRetVal: 123.
	self assert: t retVal equals: 123.
]

{ #category : #test }
SteloNativeThreadTest >> testPrivSWorld [
	| w1 w2 e |
	w1 := self newWorld.
	e := self newThread: w1.
	self assert: e privSWorld equals: w1.
	w2 := self newWorld.
	e privSWorld: w2.
	self assert: e privSWorld equals: w2.
]

{ #category : #test }
SteloNativeThreadTest >> testPush [
	| e |
	e := self newThread.
	self assert: e stack isEmpty.
	e push: 10.
	e push: 20.
	self assert: e stack size equals: 2.
	self assertCollection: e stack asArray equals: #(10 20).
]

{ #category : #test }
SteloNativeThreadTest >> testPush0 [
	| e |
	e := self newThread.
	self assert: e stack isEmpty.
	e push0.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(0).
	e push0.
	self assert: e stack size equals: 2.
	self assertCollection: e stack asArray equals: #(0 0).
]

{ #category : #test }
SteloNativeThreadTest >> testPush1 [
	| e |
	e := self newThread.
	self assert: e stack isEmpty.
	e push1.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(1).
	e push1.
	self assert: e stack size equals: 2.
	self assertCollection: e stack asArray equals: #(1 1).
]

{ #category : #test }
SteloNativeThreadTest >> testPushFloat [
	| e |
	e := self newThread.
	e codes: #(16r00 16r00 16rF6 16r42).
	self assert: e stack isEmpty.
	e pushFloat.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(123.0)
]

{ #category : #test }
SteloNativeThreadTest >> testPushShort [
	| e |
	e := self newThread.
	e codes: #(16r03 16r00).
	self assert: e stack isEmpty.
	e pushShort.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(3).
	e := self newThread.
	e codes: #(16rFD 16rFF).
	self assert: e stack isEmpty.
	e pushShort.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(-3)
]

{ #category : #test }
SteloNativeThreadTest >> testRandomFromTo [
	| t |
	t := self newThread.
	100
		timesRepeat: [ self assert: t stack size equals: 0.
			t push: 5.
			t push: 10.
			t randomFromTo.
			self assert: t stack size equals: 1.
			self assert: (t pop between: 5 and: 10) ].
]

{ #category : #test }
SteloNativeThreadTest >> testRetVal [
	self testPrivRetVal.
]

{ #category : #test }
SteloNativeThreadTest >> testReturn [
	| e |
	e := self newThread.
	e pc: 20.
	e push: 30.
	e push: 10.
	e return.
	self assert: e pc equals: 30.
	self assert: e stack size equals: 0.
	self assert: e retVal equals: 10.
]

{ #category : #test }
SteloNativeThreadTest >> testReturnValue [
	| e w c ret |
	w := self newWorld.
	w create: 3 turtles: 1.
	c := self sampleCode2.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e codes: c.
	ret := e evaluate: 9.
	self assert: ret equals: 9.
	self assert: e stack isEmpty.
	self assert: e pc equals: c size + 1.
]

{ #category : #test }
SteloNativeThreadTest >> testRounded [
	| t |
	t := self newThread.
	t push: 1.4.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: 1.5.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 2.
	t push: -1.5.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -2.
]

{ #category : #test }
SteloNativeThreadTest >> testSetBreedVarTo [
	| w t v |
	w := self newWorld.
	t := self newThread: w.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	self assert: (w patches privVariables var: v at: 1) equals: 0.
	self assert: t stack size equals: 0.
	t push: 1.
	t push: 2.
	t push: v.
	t push: SBreedId patchBreedNo.
	t setBreedVarTo.
	self assert: (w patches privVariables var: v at: 1) equals: 2.
	self assert: t stack size equals: 0.
	t push: 1.
	t push: 3.
	t push: v.
	t push: SBreedId patchBreedNo.
	t setBreedVarTo.
	self assert: (w patches privVariables var: v at: 1) equals: 3.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testSetColorTo [
	| w t ret |
	w := self newWorld.
	w create: 3 turtles: 2.

	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t push: 10.
	t setColorTo.

	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t push: 15.
	t setColorTo.

	t := self newThread: w.
	t forPatchId: 1.
	t push: 20.
	t setColorTo.

	ret := w var: STurtleVarDef colorVarNo breed: 3 at: 1.
	self assert: ret equals: 10.
	ret := w var: STurtleVarDef colorVarNo breed: 3 at: 2.
	self assert: ret equals: 15.
	ret := w var: STurtleVarDef colorVarNo breed: 2 at: 1.
	self assert: ret equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testSetHeading [
	| w t h |
	w := self newWorld.
	w create: 3 turtles: 2.
	h := (w breedOf: 3) headingAt: 2.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	self assert: t stack size equals: 0.
	t push: 10.
	t setHeading.
	self assert: t stack size equals: 0.
	self assert: ((w breedOf: 3) headingAt: 1) equals: 10.
	self assert: ((w breedOf: 3) headingAt: 2) equals: h.
	t push: 20.
	t setHeading.
	self assert: t stack size equals: 0.
	self assert: ((w breedOf: 3) headingAt: 1) equals: 20.
	self assert: ((w breedOf: 3) headingAt: 2) equals: h.
]

{ #category : #test }
SteloNativeThreadTest >> testSetLineOfListTo [
	| w t v |
	w := self newWorld.
	w create: SBreedId turtleBreedNo turtles: 1.
	v := (w breedOf: SBreedId turtleBreedNo) addList: 'a'.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 10.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 20.
	w var: v breed: SBreedId turtleBreedNo list: 1 add: 30.
	t := self newThread: w.
	t forBreedNo: SBreedId turtleBreedNo index: 1.
	t push: 2.
	t push: 40.
	t push: v.
	t setLineOfListTo.
	self assert: t stack size equals: 0.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 1) equals: 10.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 2) equals: 40.
	self assert: (w var: v breed: SBreedId turtleBreedNo list: 1 at: 3) equals: 30
]

{ #category : #test }
SteloNativeThreadTest >> testSetPatchColorTo [
	| w t ret |
	w := self newWorld.
	w create: 3 turtles: 2.

	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t push: 1.
	t push: 10.
	t setPatchColorTo.

	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t push: 2.
	t push: 15.
	t setPatchColorTo.

	t := self newThread: w.
	t forPatchId: 1.
	t push: 3.
	t push: 20.
	t setPatchColorTo.

	ret := w var: STurtleVarDef colorVarNo breed: 2 at: 1.
	self assert: ret equals: 10.
	ret := w var: STurtleVarDef colorVarNo breed: 2 at: 2.
	self assert: ret equals: 15.
	ret := w var: STurtleVarDef colorVarNo breed: 2 at: 3.
	self assert: ret equals: 20.
]

{ #category : #test }
SteloNativeThreadTest >> testSetRandomSeed [
	| w t r a b |
	w := self newWorld.
	t := self newThread: w.
	t forObserver.
	self assert: t stack size equals: 0.
	t push: 1234.
	t setRandomSeed.
	self assert: t stack size equals: 0.
	r := Random seed: 1234.
	a := w randomFrom: 1 to: 10.
	b := (1 to: 10) atRandom: r.
	self assert: a equals: b.
	a := w randomFrom: 1 to: 10.
	b := (1 to: 10) atRandom: r.
	self assert: a equals: b
]

{ #category : #test }
SteloNativeThreadTest >> testSetVarTo [
	| w t v1 v2 |
	w := self newWorld.
	t := self newThread: w.
	w create: 3 turtles: 1.
	t forBreedNo: 3 index: 1.
	v1 := (w breedOf: 3) addVariable: 'a'.
	v2 := (w breedOf: 3) addVariable: 'b'.
	self assert: (w var: v1 breed: 3 at: 1) equals: 0.
	self assert: (w var: v2 breed: 3 at: 1) equals: 0.
	self assert: t stack size equals: 0.
	t push: v1.
	t push: 123.
	t setVarTo.
	t push: v2.
	t push: 456.
	t setVarTo.
	self assert: (w var: v1 breed: 3 at: 1) equals: 123.
	self assert: (w var: v2 breed: 3 at: 1) equals: 456.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testSetX [
	| w t |
	w := self newWorld.
	w create: 3 turtles: 2.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	self assert: t stack size equals: 0.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.
	t push: 10.
	t setX.
	self assert: t stack size equals: 0.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 10.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.
	t push: 20.
	t setX.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 20.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testSetY [
	| w t |
	w := self newWorld.
	w create: 3 turtles: 2.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	self assert: t stack size equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0.
	t push: 10.
	t setY.
	self assert: t stack size equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 10.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0.
	t push: 20.
	t setY.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 20.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testSin [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 90.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 180.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 270.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.
]

{ #category : #test }
SteloNativeThreadTest >> testSqrt [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 2.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2 sqrt.
	self deny: t isTerminated.
	t push: -5.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t isTerminated.
]

{ #category : #test }
SteloNativeThreadTest >> testStack [
	| e |
	e := self newThread.
	self assert: e stack isCollection.
	self assert: e stack isEmpty.
]

{ #category : #test }
SteloNativeThreadTest >> testStop [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t stop.
	self deny: t isRunning.
	self deny: t isTerminated.
]

{ #category : #test }
SteloNativeThreadTest >> testStopAll [
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t stopAll.
	self deny: t isRunning.
	self assert: t isTerminated.
]

{ #category : #test }
SteloNativeThreadTest >> testSwap [
	| t |
	t := self newThread.
	t push: 1.
	t push: 2.
	t swap.
	self assert: t pop equals: 1.
	self assert: t pop equals: 2.
]

{ #category : #test }
SteloNativeThreadTest >> testTan [
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 60.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 3 sqrt.
	t push: 30.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: (1 / 3 sqrt).

]

{ #category : #test }
SteloNativeThreadTest >> testTruncated [
	| t |
	t := self newThread.
	t push: 1.4.
	self assert: t stack size equals: 1.
	t truncated.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: 1.5.
	self assert: t stack size equals: 1.
	t truncated.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: -1.5.
	self assert: t stack size equals: 1.
	t truncated.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -1.
]

{ #category : #test }
SteloNativeThreadTest >> testTurtleAt [
	| w t ret pno |
	w := self newWorld.
	t := self newThread: w.
	w create: 3 turtles: 2.
	t forBreedNo: 3 index: 0.
	self assert: t stack size equals: 0.
	pno := w patches indexAtX: 0 y: 0.
	t push: pno.
	t push: 3.
	t turtleAt.
	ret := t pop.
	self assert: (ret = 1 or: [ ret = 2 ]).
	self assert: t stack size equals: 0.
	t forBreedNo: 3 index: 1.
	self assert: t stack size equals: 0.
	pno := w patches indexAtX: 0 y: 0.
	t push: pno.
	t push: 3.
	t turtleAt.
	ret := t pop.
	self assert: ret equals: 2.
	self assert: t stack size equals: 0.
	t forBreedNo: 3 index: 2.
	self assert: t stack size equals: 0.
	pno := w patches indexAtX: 0 y: 0.
	t push: pno.
	t push: 3.
	t turtleAt.
	ret := t pop.
	self assert: ret equals: 1.
	self assert: t stack size equals: 0.
]

{ #category : #test }
SteloNativeThreadTest >> testXyOf [
	| w t |
	w := self newWorld.
	t := self newThread: w.
	w createPatch: 4.
	t push: 11.
	t xyOf.
	self assert: t pop equals: 0.
	self assert: t pop equals: 0.
	t push: 1.
	t xyOf.
	self assert: t pop equals: -2.
	self assert: t pop equals: -2.
	t push: 16.
	t xyOf.
	self assert: t pop equals: 1.
	self assert: t pop equals: 1.
	t push: 7.
	t xyOf.
	self assert: t pop equals: -1.
	self assert: t pop equals: 0.
]
