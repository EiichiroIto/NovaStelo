test
testGetId
	| w b t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	b := self newGenerator.
	ret := b getId.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.
	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
	t := self newThread: w.
	t forPatchId: 3.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.