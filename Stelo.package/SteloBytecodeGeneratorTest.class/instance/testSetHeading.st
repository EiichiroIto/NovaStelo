test
testSetHeading
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