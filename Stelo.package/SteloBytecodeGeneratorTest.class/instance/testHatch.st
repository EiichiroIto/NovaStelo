test
testHatch
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