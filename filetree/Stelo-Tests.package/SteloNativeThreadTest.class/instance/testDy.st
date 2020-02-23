test
testDy
	| e w |
	w := self newWorld.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 0.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dy.
	self assert: e pop closeTo: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 90.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dy.
	self assert: e pop closeTo: 1.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 180.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dy.
	self assert: e pop closeTo: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 270.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e dy.
	self assert: e pop closeTo: -1