Class {
	#name : #SPluginWorldTest,
	#superclass : #TestCase,
	#category : #'Stelo-Tests'
}

{ #category : #running }
SPluginWorldTest >> setUp [
	super setUp.
	SteloLibCall new reset.
]

{ #category : #running }
SPluginWorldTest >> tearDown [
	super tearDown.
	SteloLibCall new reset.
]

{ #category : #test }
SPluginWorldTest >> testClearBreed [
	| c x t |
	c := SPluginWorld new.
	c createPatch: 10.
	x := c var: SPatchVarDef colorVarNo breed: SBreedId patchBreedNo at: 1.
	self assert: x equals: 0.
	c var: SPatchVarDef colorVarNo breed: SBreedId patchBreedNo at: 1 put: 10.
	x := c var: SPatchVarDef colorVarNo breed: SBreedId patchBreedNo at: 1.
	self assert: x equals: 10.
	c clearBreed: SBreedId patchBreedNo.
	x := c var: SPatchVarDef colorVarNo breed: SBreedId patchBreedNo at: 1.
	self assert: x equals: 0.

	self assert: (c countAliveOf: SBreedId turtleBreedNo) equals: 0.
	t := STurtles new breedNo: SBreedId turtleBreedNo.
	c addBreed: t.
	self assert: (c countAliveOf: SBreedId turtleBreedNo) equals: 0.
	c create: SBreedId turtleBreedNo turtles: 50.
	self assert: (c countAliveOf: SBreedId turtleBreedNo) equals: 50.
	c clearBreed: SBreedId turtleBreedNo.
	self assert: (c countAliveOf: SBreedId turtleBreedNo) equals: 0.
	self assert: (c sizeOf: SBreedId turtleBreedNo) equals: 100.
]

{ #category : #test }
SPluginWorldTest >> testCountAliveOf [
	| c t |
	c := SPluginWorld new.
	c createPatch: 10.
	self assert: (c countAliveOf: 2) equals: 100.
	self assert: (c countAliveOf: 3) equals: 0.
	t := STurtles new breedNo: 3.
	c addBreed: t.
	self assert: (c countAliveOf: 3) equals: 0.
	c create: 3 turtles: 50.
	self assert: (c countAliveOf: 3) equals: 50.
	c create: 3 turtles: 5.
	self assert: (c countAliveOf: 3) equals: 55
]

{ #category : #test }
SPluginWorldTest >> testCreatePatch [
	self testCountAliveOf.
]

{ #category : #test }
SPluginWorldTest >> testCreateTurtles [
	self testCountAliveOf.
]

{ #category : #test }
SPluginWorldTest >> testGetByteAllBreed [
	| w t arr |
	w := SPluginWorld new.
	t := STurtles new breedNo: 3.
	t create: 2.
	w addBreed: t.
	arr := w getByteAll: STurtleVarDef colorVarNo breed: 3.
	self assert: arr size equals: 100.
	self assert: arr first equals: (t colorAt: 1).
	self assert: arr second equals: (t colorAt: 2).
	self assert: arr third equals: (t colorAt: 3).
]

{ #category : #test }
SPluginWorldTest >> testGetFloatAllBreed [
	| w t arr |
	w := SPluginWorld new.
	t := STurtles new breedNo: 3.
	t create: 5.
	Transcript show: (SteloLibCall new getErrorMessage); cr.
	w addBreed: t.
	Transcript show: (SteloLibCall new getErrorMessage); cr.
	"w plugin createTurtleSize: 5 breedId: 3."
	w var: STurtleVarDef xVarNo breed: 3 at: 1 put: 10.0.
	Transcript show: (SteloLibCall new getErrorMessage); cr.
	w var: STurtleVarDef xVarNo breed: 3 at: 2 put: 20.0.
	"(w plugin getFloatAll: 3 breed: 3) inspect."
	arr := w getFloatAll: STurtleVarDef xVarNo breed: 3.
	self assert: arr size equals: 100.
	self assert: arr first closeTo: 10.
	self assert: arr second closeTo: 20.
	self assert: arr third closeTo: 0.
]

{ #category : #test }
SPluginWorldTest >> testIsPluginWorld [
	self assert: SPluginWorld new isPluginWorld
]

{ #category : #test }
SPluginWorldTest >> testSetByteAllBreedFrom [
	| w t arr r |
	w := SPluginWorld new.
	t := STurtles new breedNo: 3.
	t create: 50.
	w addBreed: t.
	arr := #(10 200 30 40 50 60 7 8 9 10) asByteArray.
	w setByteAll: STurtleVarDef colorVarNo breed: 3 from: arr.
	r := w var: STurtleVarDef colorVarNo breed: 3 at: 1.
	self assert: r equals: 10.
]

{ #category : #test }
SPluginWorldTest >> testSizeOf [
	| c t |
	c := SPluginWorld new.
	c createPatch: 11.
	self assert: (c sizeOf: 2) equals: 121.
	t := STurtles new breedNo: 3.
	c addBreed: t.
	self assert: (c countAliveOf: 3) equals: 0.
	c create: 3 turtles: 5.
	self assert: (c sizeOf: 3) equals: 100.
]
