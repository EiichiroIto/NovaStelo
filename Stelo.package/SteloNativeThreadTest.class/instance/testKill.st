test
testKill
	| w e s |
	w := self newWorld.
	w create: 3 turtles: 2.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e codes: #(1 2 3 4).
	s := e stack size.
	self assert: ((w breedOf: 3) aliveAt: 1).
	e push: 3.
	e push: 1.
	e kill.
	self assert: e stack size equals: s.
	self assert: ((w breedOf: 3) aliveAt: 1) not.
	self deny: e isRunning.