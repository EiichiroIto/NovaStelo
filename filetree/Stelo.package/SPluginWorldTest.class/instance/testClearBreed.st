test
testClearBreed
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