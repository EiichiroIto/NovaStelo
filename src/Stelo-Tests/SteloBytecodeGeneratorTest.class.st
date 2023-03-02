"
A SBytecodeGeneratorTest is a test class for testing the behavior of SBytecodeGenerator
"
Class {
	#name : #SteloBytecodeGeneratorTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #private }
SteloBytecodeGeneratorTest >> choice: anInteger [

	^ SVarArgMorph new
		  choice: anInteger;
		  yourself
]

{ #category : #private }
SteloBytecodeGeneratorTest >> literalValue: anObject [

	^ SLiteralArgMorph new
		  value: anObject;
		  yourself
]

{ #category : #private }
SteloBytecodeGeneratorTest >> newApplication [

	| app |
	app := SpStelo new.
	app settings: SpStelo settingsClass new.
	app presenter: app newPresenter.
	app sworld: self newWorld.
	app installNewProject: app createProject.
	^ app
]

{ #category : #private }
SteloBytecodeGeneratorTest >> newGenerator [

	^ SteloBytecodeGenerator new
		  parser: ScratchBlockParser new;
		  yourself
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
SteloBytecodeGeneratorTest >> testAimHigh [

	| w v ret b t app |
	app := self newApplication.
	w := app sworld.
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
	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b aimHigh: (self choice: 'a').
	t := self newThread: w.
	t forBreedNo: SBreedId turtlesBreedNo index: 1.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: -45
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testAndWith [

	| t b r |
	b := self newGenerator.
	r := b and: (self literalValue: 1) with: (self literalValue: 1).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b and: (self literalValue: 1) with: (self literalValue: 0).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b and: (self literalValue: 0) with: (self literalValue: 1).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b and: (self literalValue: 0) with: (self literalValue: 0).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testBroadcast [
	| w b t e eventId |
	w := self newWorld.
	w create: 3 turtles: 1.
	eventId := EventId new.
	e := eventId newNo.
	b := self newGenerator.
	b broadcast: (self literalValue: e).
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
	b return: (self literalValue: 1).
	b callSub: (self choice: 'def').
	b address: 5.
	r := b code.
	self assertCollection: r equals: #(push1 return pushShort 3 0 call stop).
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangeObserverVarBy [

	| app w vid b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	vid := (w breedOf: SBreedId observerBreedNo) addVariable: 'a'.
	w
		var: vid
		breed: SBreedId observerBreedNo
		at: 1
		put: 6.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId observerBreedNo).
	b changeObserverVar: (self choice: 'a') by: (self literalValue: 2).
	t := self newThread: w.
	t forBreedNo: SBreedId turtlesBreedNo index: 1.
	t codes: b code.
	t execute: 1.

	self
		assert: (w var: vid breed: SBreedId observerBreedNo at: 1)
		equals: 8
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangePatchVarAtBy [

	| app w b vid t pno |
	app := self newApplication.
	w := app sworld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	w patches var: vid at: 2 put: 1.
	w patches var: vid at: 5 put: 2.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	pno := w patchIndexAtX: 0 y: 0.
	b
		changePatchVar: (self choice: 'a')
		at: (self literalValue: pno)
		by: (self literalValue: 5).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 1.
	self assert: (w patches var: vid at: 5) equals: 7.
	w y: 3 at: 1 put: -1.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	pno := w patchIndexAtX: 0 y: -1.
	b
		changePatchVar: (self choice: 'a')
		at: (self literalValue: pno)
		by: (self literalValue: 5).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 6.
	self assert: (w patches var: vid at: 5) equals: 7
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangePatchVarBy [

	| app w vid b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	vid := (w breedOf: SBreedId patchesBreedNo) addVariable: 'a'.
	w
		var: vid
		breed: SBreedId patchesBreedNo
		at: 4
		put: 6.
	w
		var: vid
		breed: SBreedId patchesBreedNo
		at: 5
		put: 7.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b
		changePatchVar: (self choice: 'a')
		by: (self literalValue: 2).
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.

	self
		assert: (w var: vid breed: SBreedId patchesBreedNo at: 4)
		equals: 8.
	self
		assert: (w var: vid breed: SBreedId patchesBreedNo at: 5)
		equals: 9
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangeVarBy [

	| app w vid b t |
	app := self newApplication.
	w := app sworld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	w
		var: vid
		breed: 3
		at: 1
		put: 5.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b changeVar: (self choice: 'a') by: (self literalValue: 10).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: vid breed: 3 at: 1) equals: 15.
	self assert: (w var: vid breed: 3 at: 2) equals: 0.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b changeVar: (self choice: 'a') by: (self literalValue: -1).
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
		var: STurtlesVarDef xVarNo
		breed: 3
		at: 1
		put: 3.
	w
		var: STurtlesVarDef xVarNo
		breed: 3
		at: 2
		put: 4.
	b := self newGenerator.
	b changeXposBy: (self literalValue: 3).
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 3.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 2) equals: 7
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testChangeYposBy [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtlesVarDef yVarNo
		breed: 3
		at: 1
		put: 3.
	w
		var: STurtlesVarDef yVarNo
		breed: 3
		at: 2
		put: 4.
	b := self newGenerator.
	b changeYposBy: (self literalValue: 3).
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) equals: 3.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 2) equals: 7
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testClearAll [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b clearAll.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
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
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b clearGraphics.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 0.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testClearPlots [

	| w b t ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isCollection.
	self assert: ret isEmpty.

	b := self newGenerator.
	b clearPlots.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.

	ret := w plotList.
	self assert: ret size equals: 1.
	self assert: (ret first isKindOf: ScratchPlotCommand).
	self assert: ret first command equals: ScratchPlotCommand clearPlotNo
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testClearTurtle [

	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: SBreedId turtlesBreedNo turtles: 2.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.

	b := self newGenerator.
	b clearTurtle: (self literalValue: SBreedId turtlesBreedNo).

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.

	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testClearTurtles [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b clearTurtles.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testCode [

	| b arr |
	b := self newGenerator.
	b forward: (self literalValue: 1).
	b turn: (self literalValue: 15).
	arr := b code.
	self assertCollection: arr equals: #(push1 forward pushShort 15 0 pushShort 5 0 getVar plus setHeading stop).
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorBlack [

	| obj r |
	obj := self newGenerator.
	r := obj colorBlack.
	self assert: r equals: ColorList black
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorBlue [

	| obj r |
	obj := self newGenerator.
	r := obj colorBlue.
	self assert: r equals: ColorList blue
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorBrown [

	| obj r |
	obj := self newGenerator.
	r := obj colorBrown.
	self assert: r equals: ColorList brown
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorCyan [

	| obj r |
	obj := self newGenerator.
	r := obj colorCyan.
	self assert: r equals: ColorList cyan
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorGray [

	| obj r |
	obj := self newGenerator.
	r := obj colorGray.
	self assert: r equals: ColorList gray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorGreen [

	| obj r |
	obj := self newGenerator.
	r := obj colorGreen.
	self assert: r equals: ColorList green
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorLime [

	| obj r |
	obj := self newGenerator.
	r := obj colorLime.
	self assert: r equals: ColorList lime
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorMagenta [

	| obj r |
	obj := self newGenerator.
	r := obj colorMagenta.
	self assert: r equals: ColorList magenta
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorOf [

	| obj r |
	obj := self newGenerator.
	r := obj colorOf: #black.
	self assert: r equals: ColorList black.
	r := obj colorOf: #white.
	self assert: r equals: ColorList white
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorOrange [

	| obj r |
	obj := self newGenerator.
	r := obj colorOrange.
	self assert: r equals: ColorList orange
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorPink [

	| obj r |
	obj := self newGenerator.
	r := obj colorPink.
	self assert: r equals: ColorList pink
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorPurple [

	| obj r |
	obj := self newGenerator.
	r := obj colorPurple.
	self assert: r equals: ColorList purple
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorRandom [

	| obj thread r |
	100 timesRepeat: [ 
		obj := self newGenerator.
		obj colorRandom.
		thread := self newThread.
		thread codes: obj code.
		r := thread evaluate: 1.
		self assert: (r between: 0 and: ColorList colors size - 1) ]
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorRed [

	| obj r |
	obj := self newGenerator.
	r := obj colorRed.
	self assert: r equals: ColorList red
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorSky [

	| obj r |
	obj := self newGenerator.
	r := obj colorSky.
	self assert: r equals: ColorList sky
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorTurquoise [

	| obj r |
	obj := self newGenerator.
	r := obj colorTurquoise.
	self assert: r equals: ColorList turquoise
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorWhite [

	| obj r |
	obj := self newGenerator.
	r := obj colorWhite.
	self assert: r equals: ColorList white
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testColorYellow [

	| obj r |
	obj := self newGenerator.
	r := obj colorYellow.
	self assert: r equals: ColorList yellow
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testComputeFunctionOf [
	| t b r |
	b := self newGenerator.
	r := b computeFunction: (self choice: #abs) of: (self literalValue: -1).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b computeFunction: (self choice: #abs) of: (self literalValue: 10).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b computeFunction: (self choice: #sqrt) of: (self literalValue: 2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2 sqrt.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testCopyPatchVarTo [

	| app w vid1 vid2 b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	vid1 := (w breedOf: SBreedId patchesBreedNo) addVariable: 'a'.
	vid2 := (w breedOf: SBreedId patchesBreedNo) addVariable: 'b'.
	w
		var: vid1
		breed: SBreedId patchesBreedNo
		at: 4
		put: 6.
	w
		var: vid2
		breed: SBreedId patchesBreedNo
		at: 4
		put: 7.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b
		copyPatchVar: (self choice: 'a')
		to: (self choice: 'b').
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.

	self
		assert: (w var: vid1 breed: SBreedId patchesBreedNo at: 4)
		equals: 6.
	self
		assert: (w var: vid2 breed: SBreedId patchesBreedNo at: 4)
		equals: 6
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testCreatePatchesSize [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b createPatchesSize: (self literalValue: 4).
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
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
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 1
		put: 3.
	b := self newGenerator.
	b createTurtleSize: (self literalValue: 3) breedId: (self literalValue: 3).
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: 3.
	self assert: w patches size equals: 9.
	self assert: (w breedOf: 3) countAlive equals: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
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
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 2).
	t codes: b code.
	t execute: 1.
	self deny: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 2).
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	t execute: 1.
	self deny: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 2)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDiffuse4VarPercentage [
	| app w b v t arr |
	app := self newApplication.
	w := app sworld.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b diffuse4Var: (self choice: 'a') percentage: (self literalValue: 80).

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
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 2 0 2 2 0 0 0 0 0 0 0 2 0 0 0) asFloatArray.

	"
 0  0  0 10    2  0  2  2
 0  0  0  0    0  0  0  2
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  0  0  2
"
	w patches variables clearVarNo: v.
	w patches var: v at: 4 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 0 2 2 0 0 0 2 0 0 0 0 0 0 0 2) asFloatArray.

	"
 0  0  0  0    2  0  0  0
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 2  0  0  0
10  0  0  0    2  2  0  2
"
	w patches variables clearVarNo: v.
	w patches var: v at: 13 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 0 0 0 0 0 0 0 2 0 0 0 2 2 0 2) asFloatArray.

	"
 0  0  0  0    0  0  0  2
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 0  0  0  2
 0  0  0 10    2  0  2  2
"
	w patches variables clearVarNo: v.
	w patches var: v at: 16 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(0 0 0 2 0 0 0 0 0 0 0 2 2 0 2 2) asFloatArray.
	w createPatch: 3.
	w patches variables clearVarNo: v.
	w patches var: v at: 5 put: 100.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(0 20 0 20 20 20 0 20 0) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDiffuseVarPercentage [
	| app w b v t arr |
	app := self newApplication.
	w := app sworld.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b diffuseVar: (self choice: 'a') percentage: (self literalValue: 80).

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
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(2 1 0 1 1 1 0 1 0 0 0 0 1 1 0 1) asFloatArray.

	"
 0  0  0 10    2  0  2  2
 0  0  0  0    0  0  0  2
 0  0  0  0 -> 0  0  0  0
 0  0  0  0    0  0  0  2
"
	w patches variables clearVarNo: v.
	w patches var: v at: 4 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(1 0 1 2 1 0 1 1 0 0 0 0 1 0 1 1) asFloatArray.

	"
 0  0  0  0    2  0  0  0
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 2  0  0  0
10  0  0  0    2  2  0  2
"
	w patches variables clearVarNo: v.
	w patches var: v at: 13 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(1 1 0 1 0 0 0 0 1 1 0 1 2 1 0 1) asFloatArray.

	"
 0  0  0  0    0  0  0  2
 0  0  0  0    0  0  0  0
 0  0  0  0 -> 0  0  0  2
 0  0  0 10    2  0  2  2
"
	w patches variables clearVarNo: v.
	w patches var: v at: 16 put: 10.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches variables realArrayAt: v.
	self
		assertCollection: arr
		equals: #(1 0 1 1 0 0 0 0 1 0 1 1 1 0 1 2) asFloatArray.
	w createPatch: 3.
	w patches variables clearVarNo: v.
	w patches var: v at: 5 put: 100.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	arr := w patches variables realArrayAt: v.
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
	r := b directionTo: (self literalValue: pno).
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
	r := b distanceTo: (self literalValue: pno).
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
	r := b divide: (self literalValue: 100) by: (self literalValue: 2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 50.

	b := self newGenerator.
	r := b divide: (self literalValue: 12) by: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.

	b := self newGenerator.
	r := b divide: (self literalValue: 10) by: (self literalValue: -2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -5.

	b := self newGenerator.
	r := b divide: (self literalValue: 1) by: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.2.

	b := self newGenerator.
	r := b divide: (self literalValue: 2) by: (self literalValue: -4).
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
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	b := self newGenerator.
	b appendValue: true.
	i := b doIfBegin: nil.
	b die.
	b doIfEnd: i.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self deny: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testDoIfElse [

	| app w b t i |
	app := self newApplication.
	w := app sworld.
	w create: 3 turtles: 2.
	w
		var: STurtlesVarDef colorVarNo
		breed: 3
		at: 1
		put: 0.
	w
		var: STurtlesVarDef colorVarNo
		breed: 3
		at: 2
		put: 0.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b appendValue: false.
	i := b doIfBegin: nil.
	b die.
	i := b doIfElse: i.
	b setVar: (self choice: 'color') to: (self literalValue: 15).
	b doIfEnd: i.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 1)
		equals: 0.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 1)
		equals: 15.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).

	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b appendValue: true.
	i := b doIfBegin: nil.
	b die.
	i := b doIfElse: i.
	b setVar: (self choice: 'color') to: (self literalValue: 15).
	b doIfEnd: i.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 2)
		equals: 0.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 2).
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 2)
		equals: 0.
	self deny: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 2)
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
	b forward: (self literalValue: 1).
	b doRepeatEndLabels: arr.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 5
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
	b forward: (self literalValue: 1).
	b appendValue: 5.
	b getXpos.
	b appendSymbol: #less.
	b doUntilEnd: nil id: i.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 6
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
	r := b equal: (self literalValue: 12) to: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b equal: (self literalValue: 10) to: (self literalValue: -3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b equal: (self literalValue: 5) to: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b equal: (self literalValue: -2.5) to: (self literalValue: -2.5).
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
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 2) equals: 0.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 2) equals: 0.
	(w breedOf: 3) headingAt: 1 put: 45.
	b := self newGenerator.
	b forward: (self literalValue: 2 sqrt).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 1.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) equals: 1.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 2) equals: 0.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 2) equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testFront [

	| w b t ret x y |
	w := self newWorld.
	w createPatch: 5.
	w create: SBreedId turtlesBreedNo turtles: 1.
	x := w x: SBreedId turtlesBreedNo at: 1.
	y := w x: SBreedId turtlesBreedNo at: 1.
	(w breedOf: SBreedId turtlesBreedNo) headingAt: 1 put: 0.

	b := self newGenerator.
	ret := b front.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 14
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
SteloBytecodeGeneratorTest >> testGetBreedVarAt [

	| g |
	g := self newGenerator.
	g getBreed: 4 var: 5 at: 3.
	self
		assertCollection: g code
		equals:
			{ #pushShort. 3. 0. #pushShort. 5. 0. #pushShort. 4. 0. #getBreedVar.
			#stop }
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetColor [
	| w b t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: STurtlesVarDef colorVarNo
		breed: 3
		at: 1
		put: ColorList red.
	w
		var: STurtlesVarDef colorVarNo
		breed: 3
		at: 2
		put: ColorList yellow.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 1
		put: ColorList green.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 2
		put: ColorList blue.
	b := self newGenerator.
	ret := b getColor.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: ColorList red.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: ColorList blue
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetHeading [

	| w b t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: SBreedId turtlesBreedNo turtles: 1.
	w
		var: STurtlesVarDef headingVarNo
		breed: SBreedId turtlesBreedNo
		at: 1
		put: 123.

	b := self newGenerator.
	ret := b getHeading.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 123
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

	| app w b t ret |
	app := self newApplication.
	w := app sworld.
	w create: 3 turtles: 1.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId observerBreedNo).
	ret := b getObserverVar: (self choice: 'width').
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
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 3
		put: ColorList green.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 5
		put: ColorList blue.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 6
		put: ColorList yellow.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 7
		put: ColorList red.
	w
		var: SPatchesVarDef colorVarNo
		breed: 2
		at: 9
		put: ColorList lime.
	b := self newGenerator.
	pno := w patchIndexAtX: 1 y: 2.
	ret := b getPatchColorAt: (self literalValue: pno).
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: ColorList green.
	b := self newGenerator.
	ret := b getPatchColorAt: (self literalValue: 9).
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	ret := t evaluate: 1.
	self assert: ret equals: ColorList lime
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetPatchVarAt [
	| app w b vid t ret pno |
	app := self newApplication.
	w := app sworld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	w patches var: vid at: 5 put: 4.
	w patches var: vid at: 2 put: 8.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	pno := w patchIndexAtX: 0 y: 0.
	ret := b getPatchVar: (self choice: 'a') at: (self literalValue: pno).
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
SteloBytecodeGeneratorTest >> testGetTurtleBreedVar [

	| app w vid b t |
	app := self newApplication.
	w := app sworld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b
		getTurtle: (self literalValue: 1)
		breed: (self literalValue: SBreedId turtlesBreedNo)
		var: (self choice: 'a').

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	w
		var: vid
		breed: 3
		at: 1
		put: 5.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testGetVar [
	| app w vid b t ret |
	app := self newApplication.
	w := app sworld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	ret := b getVar: (self choice: 'a').
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
SteloBytecodeGeneratorTest >> testGetVarBreedNoAt [
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
	ret := b getVar: [ :x | vid ] breedNo: 3 at: 2.
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
		var: STurtlesVarDef colorVarNo
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
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 1)
		equals: 15.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 2)
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

	w var: STurtlesVarDef xVarNo breed: SBreedId turtlesBreedNo at: 1 put: 0.
	w var: STurtlesVarDef yVarNo breed: SBreedId turtlesBreedNo at: 1 put: 0.

	b := self newGenerator.
	b here.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5.

	w var: STurtlesVarDef xVarNo breed: SBreedId turtlesBreedNo at: 1 put: 1.

	b := self newGenerator.
	b here.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 6.

	w var: STurtlesVarDef yVarNo breed: SBreedId turtlesBreedNo at: 1 put: -1.

	b := self newGenerator.
	b here.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testIsBetweenAnd [
	| t b r |
	b := self newGenerator.
	r := b is: (self literalValue: 10) between: (self literalValue: 3) and: (self literalValue: 12).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: (self literalValue: 10) between: (self literalValue: 10) and: (self literalValue: 12).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: (self literalValue: 12) between: (self literalValue: 10) and: (self literalValue: 12).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: (self literalValue: 9) between: (self literalValue: 10) and: (self literalValue: 12).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b is: (self literalValue: 13) between: (self literalValue: 10) and: (self literalValue: 12).
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
		var: STurtlesVarDef flagVarNo
		breed: 3
		at: 1
		put: 1.
	w
		var: STurtlesVarDef flagVarNo
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
	b kill: (self literalValue: 2) breed: (self literalValue: 3).
	t := self newThread: w.
	t forBreedNo: 3 index: 3.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 2).
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 3).
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	self deny: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 2).
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 3)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testLessEqualThan [
	| t b r |
	b := self newGenerator.
	r := b lessEqual: (self literalValue: 12) than: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b lessEqual: (self literalValue: -10) than: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b lessEqual: (self literalValue: 5) than: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b lessEqual: (self literalValue: -2.5) than: (self literalValue: -2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testLessThan [
	| t b r |
	b := self newGenerator.
	r := b less: (self literalValue: 12) than: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: (self literalValue: -10) than: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b less: (self literalValue: 5) than: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: (self literalValue: -2.5) than: (self literalValue: -2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testMinusWith [
	| t b r |
	b := self newGenerator.
	r := b minus: (self literalValue: 12) with: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 9.

	b := self newGenerator.
	r := b minus: (self literalValue: 10) with: (self literalValue: -3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 13.

	b := self newGenerator.
	r := b minus: (self literalValue: 1.5) with: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -3.5.

	b := self newGenerator.
	r := b minus: (self literalValue: -2) with: (self literalValue: -4).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testModBy [
	| t b r |
	b := self newGenerator.
	r := b mod: (self literalValue: 12) by: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b mod: (self literalValue: 10) by: (self literalValue: -3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -2.

	b := self newGenerator.
	r := b mod: (self literalValue: 1) by: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b mod: (self literalValue: -2) by: (self literalValue: 4).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testMoreEqualThan [

	| t b r |
	b := self newGenerator.
	r := b
		     moreEqual: (self literalValue: 12)
		     than: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b
		     moreEqual: (self literalValue: -10)
		     than: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b moreEqual: (self literalValue: 5) than: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b
		     moreEqual: (self literalValue: -2.5)
		     than: (self literalValue: -2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testMoreThan [

	| t b r |
	b := self newGenerator.
	r := b less: (self literalValue: 12) than: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: (self literalValue: -10) than: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b more: (self literalValue: 5) than: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b more: (self literalValue: -2.5) than: (self literalValue: -2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b more: (self literalValue: 2.5) than: (self literalValue: -2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testMultiplyAnd [
	| t b r |
	b := self newGenerator.
	r := b multiply: (self literalValue: 12) and: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 36.

	b := self newGenerator.
	r := b multiply: (self literalValue: 10) and: (self literalValue: -3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -30.

	b := self newGenerator.
	r := b multiply: (self literalValue: 1.5) and: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.5.

	b := self newGenerator.
	r := b multiply: (self literalValue: -2) and: (self literalValue: -4).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testMultiplyVarBy [
	| app w v b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 3.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b multiplyVar: (self choice: 'a') by: (self literalValue: 2).
	w patches var: v at: 1 put: 1.
	w patches var: v at: 5 put: 2.
	w patches var: v at: 7 put: 3.
	w patches var: v at: 8 put: 4.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self
		assertCollection: (w patches variables realArrayAt: v)
		equals: #(2 0 0 0 4 0 6 8 0) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testNegated [

	| t b r |
	b := self newGenerator.
	r := b negated: (self literalValue: 12).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -12.

	b := self newGenerator.
	r := b negated: (self literalValue: -5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testNot [
	| t b r |
	b := self newGenerator.
	r := b not: (self literalValue: 1).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b not: (self literalValue: 0).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testNsum4VarTo [

	| app w v1 v2 b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 4.
	v1 := w patches addVariable: 'a'.
	v2 := w patches addVariable: 'b'.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b nsum4Var: (self choice: 'a') to: (self choice: 'b').
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
		assertCollection: (w patches variables realArrayAt: v2)
		equals: #(1 0 2 3 0 4 0 1 2 0 3 3 3 3 3 0) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testNsumVarTo [

	| app w v1 v2 b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 4.
	v1 := w patches addVariable: 'a'.
	v2 := w patches addVariable: 'b'.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b nsumVar: (self choice: 'a') to: (self choice: 'b').
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
		assertCollection: (w patches variables realArrayAt: v2)
		equals: #(4 1 5 4 3 4 3 1 5 1 6 4 6 3 6 0) asFloatArray
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testOrWith [

	| t b r |
	b := self newGenerator.
	r := b or: (self literalValue: 1) with: (self literalValue: 1).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: (self literalValue: 1) with: (self literalValue: 0).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: (self literalValue: 0) with: (self literalValue: 1).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: (self literalValue: 0) with: (self literalValue: 0).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPatchAtXY [
	| w b t |
	w := self newWorld.
	w createPatch: 3.

	b := self newGenerator.
	b patchAtX: (self literalValue: 0) y: (self literalValue: 0).
	t := self newThread: w.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5.

	b := self newGenerator.
	b patchAtX: (self literalValue: -1) y: (self literalValue: 1).
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
		var: STurtlesVarDef flagVarNo
		breed: 3
		at: 1
		put: 1.
	b := self newGenerator.
	b penDown.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	r := w var: STurtlesVarDef flagVarNo breed: 3 at: 1.
	self assert: r equals: 1 + (1 << STurtlesVarDef penDownFlagNo)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPenDown2 [

	| w b t r |
	w := self newWorld.
	w create: 3 turtles: 1.
	w
		var: STurtlesVarDef flagVarNo
		breed: 3
		at: 1
		put: 1.
	b := self newGenerator.
	b penDown: true.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	r := w var: STurtlesVarDef flagVarNo breed: 3 at: 1.
	self assert: r equals: 1 + (1 << STurtlesVarDef penDownFlagNo).
	b := self newGenerator.
	b penDown: false.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	r := w var: STurtlesVarDef flagVarNo breed: 3 at: 1.
	self assert: r equals: 1
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPenUp [

	| w b t r |
	w := self newWorld.
	w create: 3 turtles: 1.
	w
		var: STurtlesVarDef flagVarNo
		breed: 3
		at: 1
		put: 1.
	b := self newGenerator.
	b penUp.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	r := w var: STurtlesVarDef flagVarNo breed: 3 at: 1.
	self assert: r equals: 1
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPlotColor [

	| w b t ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isCollection.
	self assert: ret isEmpty.

	b := self newGenerator.
	b plot: (self literalValue: 1) color: (self literalValue: ColorList brown).
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.

	ret := w plotList.
	self assert: ret size equals: 1.
	self assert: (ret first isKindOf: ScratchPlotColor).
	self assert: ret first color equals: (ColorList default colorAt: ColorList brown)
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPlotData [
	| w b t ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isCollection.
	self assert: ret isEmpty.

	b := self newGenerator.
	b plot: (self literalValue: 1) data: (self literalValue: 2).
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	ret := w plotList.
	self assert: ret size equals: 1.
	self assertCollection: ret first class equals: ScratchPlotData.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testPlusAnd [
	| t b r |
	b := self newGenerator.
	r := b plus: (self literalValue: 12) and: (self literalValue: 3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 15.

	b := self newGenerator.
	r := b plus: (self literalValue: 10) and: (self literalValue: -3).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.

	b := self newGenerator.
	r := b plus: (self literalValue: 1.5) and: (self literalValue: 5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 6.5.

	b := self newGenerator.
	r := b plus: (self literalValue: -2) and: (self literalValue: -4).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -6.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testRandomFromTo [
	| t b r |
	b := self newGenerator.
	10
		timesRepeat: [ r := b randomFrom: (self literalValue: 1) to: (self literalValue: 10).
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
	b relativeToR: (self literalValue: 1) theta: (self literalValue: 0).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 14.

	b := self newGenerator.
	b relativeToR: (self literalValue: 1) theta: (self literalValue: 90).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 18.

	b := self newGenerator.
	b relativeToR: (self literalValue: 1) theta: (self literalValue: 180).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 12.

	b := self newGenerator.
	b relativeToR: (self literalValue: 1) theta: (self literalValue: 270).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.

	b := self newGenerator.
	b relativeToR: (self literalValue: 2) theta: (self literalValue: 0).
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
	b patchAtX: (self literalValue: 0) y: (self literalValue: 0).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 5.

	b := self newGenerator.
	b relativeToX: (self literalValue: -1) y: (self literalValue: 0).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.

	b := self newGenerator.
	b relativeToX: (self literalValue: 0) y: (self literalValue: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.
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
	r := b rounded: (self literalValue: 10).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b rounded: (self literalValue: 10.2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b rounded: (self literalValue: 10.5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 11.

	b := self newGenerator.
	r := b rounded: (self literalValue: -10.5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -11.
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testScalePatchColorFromTo [

	| app w v b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b
		scalePatch: (self choice: 'a')
		color: (self literalValue: 15)
		from: (self literalValue: 1)
		to: (self literalValue: 9).
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
		assert: (w patches var: SPatchesVarDef colorVarNo at: 1)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 6)
		equals: ColorList red - 1.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 7)
		equals: ColorList red.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 8)
		equals: ColorList red + 1.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 11)
		equals: ColorList white.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 12)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 13)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 14)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 15)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 16)
		equals: ColorList black
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testScaleValueColorFromTo [

	| app w v b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 4.
	v := w patches addVariable: 'a'.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b
		scaleValue: (self choice: 'a')
		color: (self literalValue: 15)
		from: (self literalValue: 1)
		to: (self literalValue: 9).
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
		assert: (w patches var: SPatchesVarDef colorVarNo at: 1)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 6)
		equals: ColorList red - 1.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 7)
		equals: ColorList red.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 8)
		equals: ColorList red + 1.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 11)
		equals: ColorList white.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 12)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 13)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 14)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 15)
		equals: ColorList black.
	self
		assert: (w patches var: SPatchesVarDef colorVarNo at: 16)
		equals: ColorList black
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testScreenHeight [

	| app w b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 10.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b screenHeight.

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testScreenWidth [

	| app w b t |
	app := self newApplication.
	w := app sworld.
	w createPatch: 10.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b screenWidth.

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetColor [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: STurtlesVarDef colorVarNo
		breed: 3
		at: 1
		put: ColorList red.
	w
		var: STurtlesVarDef colorVarNo
		breed: 3
		at: 2
		put: ColorList red.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 1)
		equals: ColorList red.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 2)
		equals: ColorList red.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: ColorList black.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 2)
		equals: ColorList black.
	b := self newGenerator.
	b setColor: (self literalValue: ColorList yellow).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 1)
		equals: ColorList yellow.
	self
		assert: (w var: STurtlesVarDef colorVarNo breed: 3 at: 2)
		equals: ColorList red.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: ColorList black.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 2)
		equals: ColorList yellow
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetHeading [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtlesVarDef headingVarNo
		breed: 3
		at: 1
		put: 5.
	w
		var: STurtlesVarDef headingVarNo
		breed: 3
		at: 2
		put: 5.
	b := self newGenerator.
	b setHeading: (self literalValue: 15).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtlesVarDef headingVarNo breed: 3 at: 1)
		equals: 15.
	self
		assert: (w var: STurtlesVarDef headingVarNo breed: 3 at: 2)
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
	b setPatchColorAt: (self literalValue: pno) to: (self literalValue: ColorList red).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 3)
		equals: ColorList red.
	b := self newGenerator.
	b setPatchColorAt: (self literalValue: 9) to: (self literalValue: ColorList red).
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 9)
		equals: ColorList red.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 1)
		equals: ColorList black
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetPatchVarAtTo [

	| app w b vid t pno |
	app := self newApplication.
	w := app sworld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	vid := w patches addVariable: 'a'.
	self assert: (w patches var: vid at: 2) equals: 0.
	self assert: (w patches var: vid at: 5) equals: 0.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	pno := w patchIndexAtX: 0 y: 0.
	b setPatchVar: (self choice: 'a') at: (self literalValue: pno) to: (self literalValue: 5).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 0.
	self assert: (w patches var: vid at: 5) equals: 5.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	pno := w patchIndexAtX: 0 y: -1.
	b setPatchVar: (self choice: 'a') at: (self literalValue: pno) to: (self literalValue: 5).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w patches var: vid at: 2) equals: 5.
	self assert: (w patches var: vid at: 5) equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetPlotYMax [

	| w b t ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isCollection.
	self assert: ret isEmpty.

	b := self newGenerator.
	b setPlotYMax: (self literalValue: 10).
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.

	ret := w plotList.
	self assert: ret size equals: 1.
	self assert: (ret first isKindOf: ScratchPlotCommand).
	self assert: ret first command equals: ScratchPlotCommand setPlotYMax.
	self assert: ret first args first equals: 10
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetPlotYMin [

	| w b t ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isCollection.
	self assert: ret isEmpty.

	b := self newGenerator.
	b setPlotYMin: (self literalValue: 10).
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.

	ret := w plotList.
	self assert: ret size equals: 1.
	self assert: (ret first isKindOf: ScratchPlotCommand).
	self assert: ret first command equals: ScratchPlotCommand setPlotYMin.
	self assert: ret first args first equals: 10
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetRandomSeed [
	| w b t r |
	w := self newWorld.
	r := w random.
	w createPatch: 3.
	b := self newGenerator.
	b setRandomSeed: (self literalValue: 1234).
	self assert: w random identicalTo: r.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	self deny: w random identicalTo: r
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetVarTo [

	| app w vid b t |
	app := self newApplication.
	w := app sworld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	self assert: (w var: vid breed: 3 at: 1) equals: 0.
	self assert: (w var: vid breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b script: (app scriptOf: SBreedId turtlesBreedNo).
	b setVar: (self choice: 'a') to: (self literalValue: 10).
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
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b setXpos: (self literalValue: 3).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 1) equals: 3.
	self assert: (w var: STurtlesVarDef xVarNo breed: 3 at: 2) equals: 0
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testSetYpos [
	| w b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b setYpos: (self literalValue: 5).
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtlesVarDef yVarNo breed: 3 at: 2) equals: 5
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testStamp [
	| w b t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	w
		var: STurtlesVarDef colorVarNo
		breed: 3
		at: 1
		put: 15.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 5)
		equals: 0.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 6)
		equals: 0.
	b := self newGenerator.
	b stamp.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 5)
		equals: 15.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 6)
		equals: 0.
	w x: 3 at: 1 put: 1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 5)
		equals: 15.
	self
		assert: (w var: SPatchesVarDef colorVarNo breed: 2 at: 6)
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
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
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
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w flag: STurtlesVarDef aliveFlagNo breed: 3 at: 1).
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
SteloBytecodeGeneratorTest >> testTicks [

	| app w b t |
	app := self newApplication.
	w := app sworld.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b ticks.

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	w incrementTicks.
	w incrementTicks.
	w incrementTicks.

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testTruncated [
	| t b r |
	b := self newGenerator.
	r := b truncated: (self literalValue: 10).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: (self literalValue: 10.2).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: (self literalValue: 10.5).
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10.

	b := self newGenerator.
	r := b truncated: (self literalValue: -10.5).
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
		var: STurtlesVarDef headingVarNo
		breed: 3
		at: 1
		put: 5.
	w
		var: STurtlesVarDef headingVarNo
		breed: 3
		at: 2
		put: 5.
	b := self newGenerator.
	b turn: (self literalValue: -15).
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self
		assert: (w var: STurtlesVarDef headingVarNo breed: 3 at: 1)
		equals: 5.
	self
		assert: (w var: STurtlesVarDef headingVarNo breed: 3 at: 2)
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
	b turtle: (self literalValue: 3) at: (self literalValue: pno).
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
	b turtle: (self literalValue: 3) at: (self literalValue: pno).
	t := self newThread: w.
	t forBreedNo: 3 index: 3.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
	t := self newThread: w.
	t forPatchId: (w patches indexAtPoint: 1 @ 0).
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.

	b := self newGenerator.
	b turtle: (self literalValue: 3) at: (self literalValue: pno).
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
SteloBytecodeGeneratorTest >> testTurtlesCount [

	| app w b t |
	app := self newApplication.
	w := app sworld.
	w create: SBreedId turtlesBreedNo turtles: 10.

	b := self newGenerator.
	b script: (app scriptOf: SBreedId patchesBreedNo).
	b turtlesCount: (self literalValue: SBreedId turtlesBreedNo).

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 10
]

{ #category : #test }
SteloBytecodeGeneratorTest >> testVariableArgString [

	| g r |
	g := self newGenerator.
	g script: STestScript new.
	r := g variableArgString: 'a'.
	self assert: r isNil.
	self
		assertCollection: g code
		equals: { #pushShort. 5. 0. #getVar. #stop }.
	r := g variableArgString: 'notExistVariableName'.
	self assert: r equals: 0
]
