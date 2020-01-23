test
testGetBreedId
	| w b t ret |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 1.
	b := self newGenerator.
	ret := b getBreedId.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 3.

	t := self newThread: w.
	t forPatchId: 2.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.

	t := self newThread: w.
	t forObserver.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.