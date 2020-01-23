test
testSetColorTo
	| w t ret |
	w := self newWorld.
	w create: 3 turtles: 2.

	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t push: 10.
	t setColorTo.

	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t push: 15.
	t setColorTo.

	t := self newThread: w.
	t forPatchId: 1.
	t push: 20.
	t setColorTo.

	ret := w var: STurtleVarDef colorVarNo breed: 3 at: 1.
	self assert: ret equals: 10.
	ret := w var: STurtleVarDef colorVarNo breed: 3 at: 2.
	self assert: ret equals: 15.
	ret := w var: STurtleVarDef colorVarNo breed: 2 at: 1.
	self assert: ret equals: 20.