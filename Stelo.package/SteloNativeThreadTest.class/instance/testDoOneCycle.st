test
testDoOneCycle
	| e w c |
	w := self newWorld.
	w create: 3 turtles: 1.
	w x: 3 at: 1 put: 0.
	w y: 3 at: 1 put: 0.
	w
		var: STurtleVarDef headingVarNo
		breed: 3
		at: 1
		put: 0.
	c := self sampleCode1.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e codes: c.
	self assert: e pc equals: 1.
	self assert: e stack isEmpty.
	self assert: e doOneCycle not.
	self assert: e pc equals: c size + 1.
	self assert: e stack isEmpty.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 3.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 0.
	self should: [e doOneCycle] raise: Error.