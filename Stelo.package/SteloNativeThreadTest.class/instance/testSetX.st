test
testSetX
	| w t |
	w := self newWorld.
	w create: 3 turtles: 2.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	self assert: t stack size equals: 0.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.
	t push: 10.
	t setX.
	self assert: t stack size equals: 0.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 10.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.
	t push: 20.
	t setX.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 1) equals: 20.
	self assert: (w var: STurtleVarDef xVarNo breed: 3 at: 2) equals: 0.