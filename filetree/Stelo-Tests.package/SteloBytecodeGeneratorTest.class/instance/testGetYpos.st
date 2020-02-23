test
testGetYpos
	| w b t ret |
	w := self newWorld.
	w createPatch: 5.
	w create: 3 turtles: 2.
	w y: 3 at: 1 put: 2.
	w y: 3 at: 2 put: 3.
	b := self newGenerator.
	ret := b getYpos.
	self assert: ret isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.
	b := self newGenerator.
	b getYpos.
	t := self newThread: w.
	t forPatchId: 1.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -2.
	b := self newGenerator.
	b getYpos.
	t := self newThread: w.
	t forPatchId: 7.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -1