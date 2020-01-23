test
testDx
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