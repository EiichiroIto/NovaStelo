test
testHatch
	| w e s |
	w := self newWorld.
	w create: 3 turtles: 1.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	s := e stack size.
	self assert: (w breedOf: 3) countAlive equals: 1.
	self assert: ((w breedOf: 3) aliveAt: 1).
	e hatch.
	self assert: (w breedOf: 3) countAlive equals: 2.
	self assert: ((w breedOf: 3) aliveAt: 1).
	self assert: ((w breedOf: 3) aliveAt: 2).
	self assert: e stack size equals: s.