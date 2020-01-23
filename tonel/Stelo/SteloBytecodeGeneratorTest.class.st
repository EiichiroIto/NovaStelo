"
A SBytecodeGeneratorTest is a test class for testing the behavior of SBytecodeGenerator
"
Class {
	#name : #SteloBytecodeGeneratorTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloBytecodeGeneratorTest >> newGenerator [
	^ SteloBytecodeGenerator new
]

{ #category : #private }
SteloBytecodeGeneratorTest >> newThread [
	^ SteloNativeThread sworld: SMicroWorld new
]

{ #category : #private }
SteloBytecodeGeneratorTest >> newThread: aWorld [
	^ SteloNativeThread sworld: aWorld
]

{ #category : #private }
SteloBytecodeGeneratorTest >> newWorld [
	| w |
	w := SMicroWorld new.
	w addBreed: SPatches new.
	w addBreed: (STurtles new breedNo: 3).
	^ w
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAddress [
	| b |
	b := self newGenerator.
	self assert: b address equals: 1.
	b address: 100.
	self assert: b address equals: 100.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAddressOfSubName [
	| b d |
	b := self newGenerator.
	self should: [ b addressOfSubName: 'abc' ] raise: Error.
	d := Dictionary new.
	b subTable: d.
	self should: [ b addressOfSubName: 'abc' ] raise: Error.
	d at: 'abc' put: 123.
	d at: 'def' put: 456.
	self assert: (b addressOfSubName: 'abc') equals: 123.
	self assert: (b addressOfSubName: 'def') equals: 456.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAimHighVar [
	| w v ret b t |
	w := SMicroWorld new.
	w addBreed: SPatches new.
	w addBreed: (STurtles new breedNo: 3).
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
	b := self newGenerator.
	b aimHighVar: v.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: -45
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAndWith [
	| t b r |
	b := self newGenerator.
	r := b and: true with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b and: true with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b and: false with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b and: false with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAppendCall [
	| b r |
	b := self newGenerator.
	b subTable: { 'def'->123 } asDictionary.
	self assert: b privStream contents isEmpty.
	b appendCall: 'def'.
	self assert: b privStream contents size equals: 1.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeCall.
	self assert: r subName equals: 'def'.
	self assert: r address equals: 123.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAppendLabel [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendLabel: 123.
	b appendLabel: 456.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeLabel.
	self assert: r id equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeLabel.
	self assert: r id equals: 456.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAppendSymbol [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendSymbol: #abc.
	b appendSymbol: #def.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #def.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAppendSymbolWithJump [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendSymbol: #abc withJump: 12.
	b appendSymbol: #def withJump: 34.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeSymbolWithJump.
	self assert: r selector equals: #abc.
	self assert: r labelId equals: 12.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeSymbolWithJump.
	self assert: r selector equals: #def.
	self assert: r labelId equals: 34.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAppendValue [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendValue: 123.
	b appendValue: 456.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testBinaryCommandArg1Arg2 [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b binaryCommand: #abc arg1: 123 arg2: 456.
	self assert: b privStream contents size equals: 3.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
	r := b privStream contents third.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testBroadcast [
	| w b t e eventId |
	w := self newWorld.
	w create: 3 turtles: 1.
	eventId := EventId new.
	e := eventId newNo.
	b := self newGenerator.
	b broadcast: e.
	self assert: w raisedEvents isEmpty.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w raisedEvents includes: e).
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testCallSub [
	| b r |
	b := self newGenerator.
	b subTable: { 'abc'->9. 'def'->3 } asDictionary.
	b return: 1.
	b callSub: 'def'.
	b address: 5.
	r := b code.
	self assertCollection: r equals: #(push1 return pushShort 3 0 call stop).
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangePatchVaratBy [
	| w b vid t pno |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	w patches var: vid at: 2 put: 1.
	w patches var: vid at: 5 put: 2.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: 0.
	b changePatchVar: vid at: pno by: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 1.
	self assert: (w patches var: vid at: 5) equals: 7.
	w y: 3 at: 1 put: -1.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: -1.
	b changePatchVar: vid at: pno by: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 6.
	self assert: (w patches var: vid at: 5) equals: 7
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangeVarBy [
	| w vid b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	w
		var: vid
		breed: 3
		at: 1
		put: 5.
	b := self newGenerator.
	b changeVar: vid by: 10.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: vid breed: 3 at: 1) equals: 15.
	self assert: (w var: vid breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b changeVar: vid by: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self assert: (w var: vid breed: 3 at: 1) equals: 15.
	self assert: (w var: vid breed: 3 at: 2) equals: -1
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangeXposBy [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtleVarDef xVarNo
		breed: 3
		at: 1
		put: 3.
	w
		var: STurtleVarDef xVarNo
		breed: 3
		at: 2
		put: 4.
	b := self newGenerator.
	b changeXposBy: 3.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 3.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 7
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangeYposBy [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtleVarDef yVarNo
		breed: 3
		at: 1
		put: 3.
	w
		var: STurtleVarDef yVarNo
		breed: 3
		at: 2
		put: 4.
	b := self newGenerator.
	b changeYposBy: 3.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 3.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 7
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testClearAll [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b clearAll.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 0.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testClearGraphics [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b clearGraphics.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 0.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testClearTurtles [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b clearTurtles.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testCode [
	| b arr |
	b := self newGenerator.
	b forward: 1.
	b turn: 15.
	arr := b code.
	self assertCollection: arr equals: #(push1 forward pushShort 15 0 pushShort 5 0 getVar plus setHeading stop).
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testComputeFunctionOf [
	| t b r |
	b := self newGenerator.
	r := b computeFunction: #abs of: -1.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b computeFunction: #abs of: 10.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b computeFunction: #sqrt of: 2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2 sqrt.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testCreatePatchesSize [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b createPatchesSize: 4.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 0.
	self assert: w patches size equals: 16.
	self assert: (w breedOf: 3) countAlive equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testCreateTurtleSizeBreedId [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b createTurtleSize: 3 breedId: 3.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDie [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	b := self newGenerator.
	b die.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2).
	t codes: b code.
	t execute: 1.
	self deny: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2).
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	t execute: 1.
	self deny: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDiffuse4VarPercentage [
	| w b v t arr |
	w := self newWorld.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b diffuse4Var: v percentage: 80.

	"
10  0  0  0    2  2  0  2
 0  0  0  0    2  0  0  0
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    2  0  0  0
"
	w patches var: v at: 1 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 2 0 2 2 0 0 0 0 0 0 0 2 0 0 0) asFloatArray.

	"
 0  0  0 10    2  0  2  2
 0  0  0  0    0  0  0  2
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  0  0  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 4 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 0 2 2 0 0 0 2 0 0 0 0 0 0 0 2) asFloatArray.

	"
 0  0  0  0    2  0  0  0
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 2  0  0  0
10  0  0  0    2  2  0  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 13 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 0 0 0 0 0 0 0 2 0 0 0 2 2 0 2) asFloatArray.

	"
 0  0  0  0    0  0  0  2
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 0  0  0  2
 0  0  0 10    2  0  2  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 16 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(0 0 0 2 0 0 0 0 0 0 0 2 2 0 2 2) asFloatArray.
	w createPatch: 3.
	w patches privVariables clearVarNo: v.
	w patches var: v at: 5 put: 100.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(0 20 0 20 20 20 0 20 0) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDiffuseVarPercentage [
	| w b v t arr |
	w := self newWorld.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b diffuseVar: v percentage: 80.

	"
10  0  0  0    2  2  0  2
 0  0  0  0    2  0  0  0
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    2  0  0  0
"
	w patches var: v at: 1 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 1 0 1 1 1 0 1 0 0 0 0 1 1 0 1) asFloatArray.

	"
 0  0  0 10    2  0  2  2
 0  0  0  0    0  0  0  2
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  0  0  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 4 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(1 0 1 2 1 0 1 1 0 0 0 0 1 0 1 1) asFloatArray.

	"
 0  0  0  0    2  0  0  0
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 2  0  0  0
10  0  0  0    2  2  0  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 13 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.

	"
 0  0  0  0    0  0  0  2
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 0  0  0  2
 0  0  0 10    2  0  2  2
"
	w patches privVariables clearVarNo: v.
	w patches var: v at: 16 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(1 0 1 1 0 0 0 0 1 0 1 1 1 0 1 2) asFloatArray.
	w createPatch: 3.
	w patches privVariables clearVarNo: v.
	w patches var: v at: 5 put: 100.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches privVariables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(10 10 10 10 20 10 10 10 10) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDirectionTo [
	| w t b r pno |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	w x: 3 at: 2 put: 1.
	"1  2  3  4  5
	 6  7  8  9 10
	11 12 13 14 15
	16 17 18 19 20
	21 22 23 24 25"
	b := self newGenerator.
	pno := w patchIndexAtX: 2 y: 1.
	r := b directionTo: pno.
	self assert: r isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r closeTo: 0.5 arcTan radiansToDegrees.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r closeTo: 1 arcTan radiansToDegrees.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDistanceTo [
	| w t b r pno |
	w := self newWorld.
	w create: 3 turtles: 2.
	w x: 3 at: 2 put: 1.
	b := self newGenerator.
	pno := w patchIndexAtX: 2 y: 1.
	r := b distanceTo: pno.
	self assert: r isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r closeTo: 5 sqrt.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r closeTo: 2 sqrt
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDivideBy [
	| t b r |
	b := self newGenerator.
	r := b divide: 100 by: 2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 50.

	b := self newGenerator.
	r := b divide: 12 by: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.

	b := self newGenerator.
	r := b divide: 10 by: -2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -5.

	b := self newGenerator.
	r := b divide: 1 by: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.2.

	b := self newGenerator.
	r := b divide: 2 by: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -0.5.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDoIfBegin [
	| w b t i |
	w := self newWorld.
	w create: 3 turtles: 1.
	b := self newGenerator.
	b appendValue: false.
	i := b doIfBegin: nil.
	b die.
	b doIfEnd: i.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	b := self newGenerator.
	b appendValue: true.
	i := b doIfBegin: nil.
	b die.
	b doIfEnd: i.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self deny: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDoIfElse [
	| w b t i |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 1
		put: 0.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 2
		put: 0.
	b := self newGenerator.
	b appendValue: false.
	i := b doIfBegin: nil.
	b die.
	i := b doIfElse: i.
	b setVar: STurtleVarDef colorVarNo to: 15.
	b doIfEnd: i.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 1)
		equals: 0.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 1)
		equals: 15.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	b := self newGenerator.
	b appendValue: true.
	i := b doIfBegin: nil.
	b die.
	i := b doIfElse: i.
	b setVar: STurtleVarDef colorVarNo to: 15.
	b doIfEnd: i.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 2)
		equals: 0.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2).
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 2)
		equals: 0.
	self deny: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDoIfEnd [
	self testDoIfBegin.
	self testDoIfElse.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDoRepeatBegin [
	| w b t arr |
	w := self newWorld.
	w create: 3 turtles: 1.
	(w breedOf: 3) headingAt: 1 put: 0.
	b := self newGenerator.
	b appendValue: false.
	arr := b doRepeatBegin: 5.
	b forward: 1.
	b doRepeatEndLabels: arr.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDoRepeatEndLabels [
	self testDoRepeatBegin.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDoUntilBegin [
	| w b t i |
	w := self newWorld.
	w create: 3 turtles: 1.
	(w breedOf: 3) headingAt: 1 put: 0.
	b := self newGenerator.
	i := b doUntilBegin.
	b forward: 1.
	b appendValue: 5.
	b getXpos.
	b appendSymbol: #less.
	b doUntilEnd: nil id: i.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 6
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDoUntilEndId [
	self testDoUntilBegin.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDx [
	| w b t |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	(w breedOf: 3) headingAt: 1 put: 45.
	(w breedOf: 3) headingAt: 2 put: 60.
	b := self newGenerator.
	b dx.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) closeTo: 45 degreeCos.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	self assert: (t evaluate: 1) closeTo: 60 degreeCos
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDy [
	| w b t |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	(w breedOf: 3) headingAt: 1 put: 45.
	(w breedOf: 3) headingAt: 2 put: 60.
	b := self newGenerator.
	b dy.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) closeTo: 45 degreeSin.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	self assert: (t evaluate: 1) closeTo: 60 degreeSin
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testEqualTo [
	| t b r |
	b := self newGenerator.
	r := b equal: 12 to: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b equal: 10 to: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b equal: 5 to: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b equal: -2.5 to: -2.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testForward [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0.
	(w breedOf: 3) headingAt: 1 put: 45.
	b := self newGenerator.
	b forward: 2 sqrt.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 1.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 1.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetBreedId [
	| w b t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	b := self newGenerator.
	ret := b getBreedId.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.

	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetColor [
	| w b t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 1
		put: SColorList red.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 2
		put: SColorList yellow.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 1
		put: SColorList green.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 2
		put: SColorList blue.
	b := self newGenerator.
	ret := b getColor.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: SColorList red.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: SColorList blue
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetId [
	| w b t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	b := self newGenerator.
	ret := b getId.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
	t := self newThread: w.
	t forPatchId: 3.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetObserverVar [
	| w b t ret |
	w := self newWorld.
	w addBreed: SObserver new.
	w create: 3 turtles: 1.
	b := self newGenerator.
	ret := b getObserverVar: SObserverVarDef widthVarNo.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 100.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	w createPatch: 10.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetPatchColorAt [
	| w b t ret pno |
	w := self newWorld.
	"
	1 2 3
	4 5 6
	7 8 9
"
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 3
		put: SColorList green.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 5
		put: SColorList blue.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 6
		put: SColorList yellow.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 7
		put: SColorList red.
	w
		var: SPatchVarDef colorVarNo
		breed: 2
		at: 9
		put: SColorList lime.
	b := self newGenerator.
	pno := w patchIndexAtX: 1 y: 2.
	ret := b getPatchColorAt: pno.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: SColorList green.
	b := self newGenerator.
	ret := b getPatchColorAt: 9.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: SColorList lime
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetPatchVarAt [
	| w b vid t ret pno |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	w patches var: vid at: 5 put: 4.
	w patches var: vid at: 2 put: 8.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: 0.
	ret := b getPatchVar: vid at: pno.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.
	w y: 3 at: 1 put: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetVar [
	| w vid b t ret |
	w := self newWorld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	b := self newGenerator.
	ret := b getVar: vid.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
	w
		var: vid
		breed: 3
		at: 1
		put: 20.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 20
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetVarBreedNoIndex [
	| w b vid t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := (w breedOf: 3) addVariable: 'a'.
	w
		var: vid
		breed: 3
		at: 1
		put: 4.
	w
		var: vid
		breed: 3
		at: 2
		put: 5.
	b := self newGenerator.
	ret := b getVar: [ :x | vid ] breedNo: 3 index: 2.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetXpos [
	| w b t ret |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	w x: 3 at: 1 put: 2.
	w x: 3 at: 2 put: 3.
	b := self newGenerator.
	ret := b getXpos.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
	b := self newGenerator.
	b getXpos.
	t := self newThread: w.
	t forPatchId: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -2.
	b := self newGenerator.
	b getXpos.
	t := self newThread: w.
	t forPatchId: 7.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -1
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetYpos [
	| w b t ret |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	w y: 3 at: 1 put: 2.
	w y: 3 at: 2 put: 3.
	b := self newGenerator.
	ret := b getYpos.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
	b := self newGenerator.
	b getYpos.
	t := self newThread: w.
	t forPatchId: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -2.
	b := self newGenerator.
	b getYpos.
	t := self newThread: w.
	t forPatchId: 7.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -1
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testHatch [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 1
		put: 15.
	b := self newGenerator.
	b hatch.
	self assert: (w breedOf: 3) countAlive equals: 1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w breedOf: 3) countAlive equals: 2.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 1)
		equals: 15.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 2)
		equals: 15
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testHere [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.

"1 2 3
 4 5 6
 7 8 9"

	w var: STurtleVarDef xVarNo breed: SBreedId turtleBreedNo at: 1 put: 0.
	w var: STurtleVarDef yVarNo breed: SBreedId turtleBreedNo at: 1 put: 0.

	b := self newGenerator.
	b here.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5.

	w var: STurtleVarDef xVarNo breed: SBreedId turtleBreedNo at: 1 put: 1.

	b := self newGenerator.
	b here.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 6.

	w var: STurtleVarDef yVarNo breed: SBreedId turtleBreedNo at: 1 put: -1.

	b := self newGenerator.
	b here.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testInitialize [
	self testPrivLabelId.
	self testPrivStream.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testIsBetweenAnd [
	| t b r |
	b := self newGenerator.
	r := b is: 10 between: 3 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 10 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 12 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 9 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b is: 13 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testIsPenDown [
	| w b t r |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtleVarDef flagVarNo
		breed: 3
		at: 1
		put: 1.
	w
		var: STurtleVarDef flagVarNo
		breed: 3
		at: 2
		put: 3.
	b := self newGenerator.
	b isPenDown.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testKillBreed [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 3.
	b := self newGenerator.
	b kill: 2 breed: 3.
	t := self newThread: w.
	t forBreedNo: 3 index: 3.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2).
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 3).
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	self deny: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 2).
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 3)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testLabelsAndJumpsFor [
	| b arr |
	b := self newGenerator.
	b appendLabel: b privLabelId newNo.
	b appendValue: 1.
	b appendValue: 2.
	b appendLabel: b privLabelId newNo.
	b appendSymbol: #a.
	b appendLabel: b privLabelId newNo.
	b appendValue: 2.
	b appendSymbol: #a withJump: 1.

	arr := b labelsAndJumpsFor: b privStream contents.

	self assertCollection: arr first equals: #(1 5 6).
	self assert: arr second size equals: 1.
	self assert: arr second first selector equals: #a.
	self assert: b address equals: 13.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testLessEqualThan [
	| t b r |
	b := self newGenerator.
	r := b lessEqual: 12 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b lessEqual: -10 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b lessEqual: 5 than: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b lessEqual: -2.5 than: -2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testLessThan [
	| t b r |
	b := self newGenerator.
	r := b less: 12 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: -10 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b less: 5 than: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: -2.5 than: -2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testMinusWith [
	| t b r |
	b := self newGenerator.
	r := b minus: 12 with: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 9.

	b := self newGenerator.
	r := b minus: 10 with: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 13.

	b := self newGenerator.
	r := b minus: 1.5 with: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -3.5.

	b := self newGenerator.
	r := b minus: -2 with: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testModBy [
	| t b r |
	b := self newGenerator.
	r := b mod: 12 by: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b mod: 10 by: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -2.

	b := self newGenerator.
	r := b mod: 1 by: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b mod: -2 by: 4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testMultiplyAnd [
	| t b r |
	b := self newGenerator.
	r := b multiply: 12 and: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 36.

	b := self newGenerator.
	r := b multiply: 10 and: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -30.

	b := self newGenerator.
	r := b multiply: 1.5 and: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.5.

	b := self newGenerator.
	r := b multiply: -2 and: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testMultiplyVarBy [
	| w v b t |
	w := self newWorld.
	w createPatch: 3.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b multiplyVar: v by: 2.
	w patches var: v at: 1 put: 1.
	w patches var: v at: 5 put: 2.
	w patches var: v at: 7 put: 3.
	w patches var: v at: 8 put: 4.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assertCollection: (w patches privVariables realArrayAt: v)
		equals: #(2 0 0 0 4 0 6 8 0) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testNot [
	| t b r |
	b := self newGenerator.
	r := b not: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b not: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testNsum4VarTo [
	| w v1 v2 b t |
	w := self newWorld.
	w createPatch: 4.
	v1 := w patches addVariable: 'a'.
	v2 := w patches addVariable: 'b'.
	b := self newGenerator.
	b nsum4Var: v1 to: v2.
	"
0 1 0 0     1 0 2 3
0 0 1 0 --> 0 4 0 1
0 2 0 0     2 0 3 3
0 0 0 3     3 3 3 0
"
	w patches var: v1 at: 2 put: 1.
	w patches var: v1 at: 7 put: 1.
	w patches var: v1 at: 10 put: 2.
	w patches var: v1 at: 16 put: 3.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assertCollection: (w patches privVariables realArrayAt: v2)
		equals: #(1 0 2 3 0 4 0 1 2 0 3 3 3 3 3 0) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testNsumVarTo [
	| w v1 v2 b t |
	w := self newWorld.
	w createPatch: 4.
	v1 := w patches addVariable: 'a'.
	v2 := w patches addVariable: 'b'.
	b := self newGenerator.
	b nsumVar: v1 to: v2.
	"
0 1 0 0     4 1 5 4
0 0 1 0 --> 3 4 3 1
0 2 0 0     5 1 6 4
0 0 0 3     6 3 6 0
"
	w patches var: v1 at: 2 put: 1.
	w patches var: v1 at: 7 put: 1.
	w patches var: v1 at: 10 put: 2.
	w patches var: v1 at: 16 put: 3.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assertCollection: (w patches privVariables realArrayAt: v2)
		equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testNullaryCommand [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b nullaryCommand: #abc.
	self assert: b privStream contents size equals: 1.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testOrWith [
	| t b r |
	b := self newGenerator.
	r := b or: true with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: true with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: false with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: false with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPatchAtXY [
	| w b t |
	w := self newWorld.
	w createPatch: 3.

	b := self newGenerator.
	b patchAtX: 0 y: 0.
	t := self newThread: w.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5.

	b := self newGenerator.
	b patchAtX: -1 y: 1.
	t := self newThread: w.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPenDown [
	| w b t r |
	w := self newWorld.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef flagVarNo
		breed: 3
		at: 1
		put: 1.
	b := self newGenerator.
	b penDown: true.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	r := w var: STurtleVarDef flagVarNo breed: 3 at: 1.
	self assert: r equals: 1 + (1 << STurtleVarDef penDownFlagNo).
	b := self newGenerator.
	b penDown: false.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	r := w var: STurtleVarDef flagVarNo breed: 3 at: 1.
	self assert: r equals: 1
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPlotData [
	| w b t ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isCollection.
	self assert: ret isEmpty.
	b := self newGenerator.
	b plot: 1 data: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	ret := w plotList.
	self assert: ret size equals: 1.
	self assertCollection: ret first class equals: SteloPlotData.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPlusAnd [
	| t b r |
	b := self newGenerator.
	r := b plus: 12 and: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 15.

	b := self newGenerator.
	r := b plus: 10 and: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.

	b := self newGenerator.
	r := b plus: 1.5 and: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 6.5.

	b := self newGenerator.
	r := b plus: -2 and: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -6.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPrivLabelId [
	| b |
	b := self newGenerator.
	self assert: b privLabelId class equals: BaseId.
	self assert: b privLabelId size equals: 0.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPrivStream [
	| b |
	b := self newGenerator.
	self assert: b privStream isStream.
	self assert: b privStream contents isArray.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testRandomFromTo [
	| t b r |
	b := self newGenerator.
	10
		timesRepeat: [ r := b randomFrom: 1 to: 10.
			self assert: r isNil.
			t := self newThread.
			t codes: b code.
			self assert: ((t evaluate: 1) between: 1 and: 10) ].
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testRelativeToRTheta [
	| w b t |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 1.

" 1  2  3  4  5
  6  7  8  9 10
 11 12 13 14 15
 16 17 18 19 20
 21 22 23 24 25
"

	b := self newGenerator.
	b relativeToR: 1 theta: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 14.

	b := self newGenerator.
	b relativeToR: 1 theta: 90.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 18.

	b := self newGenerator.
	b relativeToR: 1 theta: 180.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 12.

	b := self newGenerator.
	b relativeToR: 1 theta: 270.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.

	b := self newGenerator.
	b relativeToR: 2 theta: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 15.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testRelativeToXY [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.

"1 2 3
 4 5 6
 7 8 9"

	b := self newGenerator.
	b patchAtX: 0 y: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5.

	b := self newGenerator.
	b relativeToX: -1 y: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.

	b := self newGenerator.
	b relativeToX: 0 y: 1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testResolveJumpAddressUsing [
	| b fp arr |
	b := self newGenerator.
	b appendLabel: b privLabelId newNo.
	b appendValue: 1.
	b appendValue: 2.
	b appendSymbol: #a withJump: 3.
	b appendLabel: b privLabelId newNo.
	b appendSymbol: #b.
	b appendLabel: b privLabelId newNo.
	b appendValue: 2.
	b appendSymbol: #c withJump: 2.
	fp := b privStream contents.

	self assert: (fp at: 4) address equals: nil.
	self assert: (fp at: 9) address equals: nil.

	arr := b labelsAndJumpsFor: fp.
	b resolveJumpAddress: arr second using: arr first.

	self assert: (fp at: 4) address equals: 10.
	self assert: (fp at: 9) address equals: 9.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testReturn [
	self testCallSub.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testReturnValue [
	| b r |
	b := self newGenerator.
	b returnValue.
	b address: 5.
	r := b code.
	self assertCollection: r equals: #(returnValue stop).
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testRounded [
	| t b r |
	b := self newGenerator.
	r := b rounded: 10.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b rounded: 10.2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b rounded: 10.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 11.

	b := self newGenerator.
	r := b rounded: -10.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -11.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testScaleValueColorFromTo [
	| w v b t |
	w := self newWorld.
	w addBreed: SObserver new.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b
		scaleValue: v
		color: 15
		from: 1
		to: 9.
	w patches var: v at: 1 put: 0.
	w patches var: v at: 2 put: 1.
	w patches var: v at: 3 put: 2.
	w patches var: v at: 4 put: 3.
	w patches var: v at: 5 put: 4.
	w patches var: v at: 6 put: 5.
	w patches var: v at: 7 put: 6.
	w patches var: v at: 8 put: 7.
	w patches var: v at: 9 put: 8.
	w patches var: v at: 10 put: 9.
	w patches var: v at: 11 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 1)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 6)
		equals: SColorList red - 1.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 7)
		equals: SColorList red.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 8)
		equals: SColorList red + 1.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 11)
		equals: SColorList white.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 12)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 13)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 14)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 15)
		equals: SColorList black.
	self
		assert: (w patches var: SPatchVarDef colorVarNo at: 16)
		equals: SColorList black
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetColorTo [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 1
		put: SColorList red.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 2
		put: SColorList red.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 1)
		equals: SColorList red.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 2)
		equals: SColorList red.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: SColorList black.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 2)
		equals: SColorList black.
	b := self newGenerator.
	b setColorTo: SColorList yellow.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 1)
		equals: SColorList yellow.
	self
		assert: (w var: STurtleVarDef colorVarNo breed: 3 at: 2)
		equals: SColorList red.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: SColorList black.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 2)
		equals: SColorList yellow
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetHeading [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 5.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 2
		put: 5.
	b := self newGenerator.
	b setHeading: 15.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtleVarDef headingVarNo breed: 3 at: 1)
		equals: 15.
	self
		assert: (w var: STurtleVarDef headingVarNo breed: 3 at: 2)
		equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetPatchColorAtTo [
	| w b t pno |
	w := self newWorld.
	"
	1 2 3
	4 5 6
	7 8 9
"
	w createPatch: 3.
	w create: 3 turtles: 1.
	b := self newGenerator.
	pno := w patchIndexAtX: 1 y: 2.
	b setPatchColorAt: pno to: SColorList red.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 3)
		equals: SColorList red.
	b := self newGenerator.
	b setPatchColorAt: 9 to: SColorList red.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 9)
		equals: SColorList red.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 1)
		equals: SColorList black
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetPatchVarAtTo [
	| w b vid t pno |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	self assert: (w patches var: vid at: 2) equals: 0.
	self assert: (w patches var: vid at: 5) equals: 0.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: 0.
	b setPatchVar: vid at: pno to: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 0.
	self assert: (w patches var: vid at: 5) equals: 5.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: -1.
	b setPatchVar: vid at: pno to: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 5.
	self assert: (w patches var: vid at: 5) equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetVarTo [
	| w vid b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	self assert: (w var: vid breed: 3 at: 1) equals: 0.
	self assert: (w var: vid breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b setVar: vid to: 10.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: vid breed: 3 at: 1) equals: 10.
	self assert: (w var: vid breed: 3 at: 2) equals: 0.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetXpos [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b setXpos: 3.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 3.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetYpos [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b setYpos: 5.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testStamp [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef colorVarNo
		breed: 3
		at: 1
		put: 15.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 5)
		equals: 0.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 6)
		equals: 0.
	b := self newGenerator.
	b stamp.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 5)
		equals: 15.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 6)
		equals: 0.
	w x: 3 at: 1 put: 1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 5)
		equals: 15.
	self
		assert: (w var: SPatchVarDef colorVarNo breed: 2 at: 6)
		equals: 15
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testStopAll [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 1.
	b := self newGenerator.
	b stopAll.
	b die.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	self assert: t isTerminated.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testStopThread [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 1.
	b := self newGenerator.
	b stopThread.
	b die.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtleVarDef aliveFlagNo breed: 3 at: 1).
	self deny: t isTerminated.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSubTable [
	| b d |
	b := self newGenerator.
	self assert: b subTable isNil.
	d := Dictionary new.
	b subTable: d.
	self assert: b subTable equals: d.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testTernaryCommandArg1Arg2Arg3 [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b ternaryCommand: #abc arg1: 123 arg2: 456 arg3: 789.
	self assert: b privStream contents size equals: 4.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
	r := b privStream contents third.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 789.
	r := b privStream contents fourth.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testTruncated [
	| t b r |
	b := self newGenerator.
	r := b truncated: 10.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: 10.2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: 10.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: -10.5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -10.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testTurn [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 5.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 2
		put: 5.
	b := self newGenerator.
	b turn: -15.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtleVarDef headingVarNo breed: 3 at: 1)
		equals: 5.
	self
		assert: (w var: STurtleVarDef headingVarNo breed: 3 at: 2)
		equals: 350
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testTurtleAt [
	| w b t pno |
	w := self newWorld.
	w create: 3 turtles: 3.
	w x: 3 at: 3 put: 1.
	b := self newGenerator.
	pno := w patchIndexAtX: 0 y: 0.
	b turtle: 3 at: pno.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
	b := self newGenerator.
	pno := w patchIndexAtX: 1 y: 0.
	b turtle: 3 at: pno.
	t := self newThread: w.
	t forBreedNo: 3 index: 3.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
	t := self newThread: w.
	t forPatchId: (w patches indexAtPoint: 1 @ 0).
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.
	b := self newGenerator.
	b turtle: 3 at: pno.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.
	t := self newThread: w.
	t forBreedNo: 3 index: 3.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testUnaryCommandArg [
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b unaryCommand: #abc arg: 123.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.
]
