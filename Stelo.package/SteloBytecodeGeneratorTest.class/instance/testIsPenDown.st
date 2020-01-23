test
testIsPenDown
	| w b t r |
	w := self newWorld.
	w create: 3 turtles: 2.
	w
		var: STurtleVarDef flagVarNo
		breed: 3
		at: 1
		put: 1.
	w
		var: STurtleVarDef flagVarNo
		breed: 3
		at: 2
		put: 3.
	b := self newGenerator.
	b isPenDown.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 0.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 1.