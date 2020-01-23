test
testChangeVarBy
	| w vid b t |
	w := self newWorld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	w
		var: vid
		breed: 3
		at: 1
		put: 5.
	b := self newGenerator.
	b changeVar: vid by: 10.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	t execute: 1.
	self assert: (w var: vid breed: 3 at: 1) equals: 15.
	self assert: (w var: vid breed: 3 at: 2) equals: 0.
	b := self newGenerator.
	b changeVar: vid by: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	t execute: 1.
	self assert: (w var: vid breed: 3 at: 1) equals: 15.
	self assert: (w var: vid breed: 3 at: 2) equals: -1