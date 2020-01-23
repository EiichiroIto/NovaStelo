test
testHere
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