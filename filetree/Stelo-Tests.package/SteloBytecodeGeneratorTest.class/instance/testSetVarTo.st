test
testSetVarTo
	| w vid b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	self assert: (w var: vid breed: 3 at: 1) equals: 0.
	self assert: (w var: vid breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b setVar: vid to: 10.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: vid breed: 3 at: 1) equals: 10.
	self assert: (w var: vid breed: 3 at: 2) equals: 0.