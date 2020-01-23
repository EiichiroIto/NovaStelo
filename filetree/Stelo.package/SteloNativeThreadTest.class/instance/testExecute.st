test
testExecute
	| w t c x |
	w := self newWorld.
	t := self newThread: w.
	w create: 3 turtles: 1.
	w var: STurtleVarDef colorVarNo breed: 3 at: 1 put: SColorList black.
	c := {#pushShort. SColorList white. 0. #setColorTo. #stop}.
	t forBreedNo: 3 index: 1.
	t codes: c.
	t execute: 1.
	x := w var: STurtleVarDef colorVarNo breed: 3 at: 1.
	self assert: x equals: SColorList white.