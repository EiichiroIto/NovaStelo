test
testForward
	| e w |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 1.
	w x: 3 at: 1 put: 0.
	w y: 3 at: 1 put: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 0.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e push: 1.
	e forward.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) closeTo: 1.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	e push: 2.
	e forward.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -2.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0