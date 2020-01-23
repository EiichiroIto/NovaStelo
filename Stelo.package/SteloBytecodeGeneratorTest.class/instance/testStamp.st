test
testStamp
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