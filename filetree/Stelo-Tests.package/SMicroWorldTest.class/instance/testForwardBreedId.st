tests-command
testForwardBreedId
	| w |
	w := self newWorld.
	w createPatch: 100.
	w create: 3 turtles: 1.
	(w breedOf: 3) headingAt: 1 put: 0.
	w x: 3 at: 1 put: 49.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -50.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 49.1.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.9.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 49.9.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.1.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	w x: 3 at: 1 put: 50.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: -49.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) closeTo: 0.
	(w breedOf: 3) headingAt: 1 put: 90.
	w x: 3 at: 1 put: 49.
	w y: 3 at: 1 put: 49.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1)
		closeTo: -50.
	w y: 3 at: 1 put: 49.1.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1)
		closeTo: -49.9.
	w y: 3 at: 1 put: 49.9.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1)
		closeTo: -49.1.
	w y: 3 at: 1 put: 50.
	w forward: 1 breed: 3 id: 1.
	self
		assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1)
		closeTo: 49.
	self
		assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1)
		closeTo: -49