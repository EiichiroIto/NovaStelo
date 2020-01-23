test
testPenDown
	| w b t r |
	w := self newWorld.
	w create: 3 turtles: 1.
	w
		var: STurtleVarDef flagVarNo
		breed: 3
		at: 1
		put: 1.
	b := self newGenerator.
	b penDown: true.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	r := w var: STurtleVarDef flagVarNo breed: 3 at: 1.
	self assert: r equals: 1 + (1 << STurtleVarDef penDownFlagNo).
	b := self newGenerator.
	b penDown: false.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	r := w var: STurtleVarDef flagVarNo breed: 3 at: 1.
	self assert: r equals: 1