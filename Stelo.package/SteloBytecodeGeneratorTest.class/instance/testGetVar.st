test
testGetVar
	| w vid b t ret |
	w := self newWorld.
	w create: 3 turtles: 2.
	vid := (w breedOf: 3) addVariable: 'a'.
	b := self newGenerator.
	ret := b getVar: vid.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.
	w
		var: vid
		breed: 3
		at: 1
		put: 20.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 20