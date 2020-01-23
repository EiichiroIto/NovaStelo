test
testDistanceTo
	| w t b r pno |
	w := self newWorld.
	w create: 3 turtles: 2.
	w x: 3 at: 2 put: 1.
	b := self newGenerator.
	pno := w patchIndexAtX: 2 y: 1.
	r := b distanceTo: pno.
	self assert: r isNil.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r closeTo: 5 sqrt.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r closeTo: 2 sqrt