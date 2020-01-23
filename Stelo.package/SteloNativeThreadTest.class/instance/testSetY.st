test
testSetY
	| w t |
	w := self newWorld.
	w create: 3 turtles: 2.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	self assert: t stack size equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0.
	t push: 10.
	t setY.
	self assert: t stack size equals: 0.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 10.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0.
	t push: 20.
	t setY.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 1) equals: 20.
	self assert: (w var: STurtleVarDef yVarNo breed: 3 at: 2) equals: 0.