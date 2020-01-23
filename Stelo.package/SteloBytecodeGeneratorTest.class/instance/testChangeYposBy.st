test
testChangeYposBy
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