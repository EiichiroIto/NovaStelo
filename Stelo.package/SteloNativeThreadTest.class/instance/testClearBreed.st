test
testClearBreed
	| w e |
	w := self newWorld.
	w create: 3 turtles: 5.
	w addBreed: (STurtles new breedNo: 4).
	w create: 4 turtles: 10.
	e := self newThread: w.
	self assert: (w breedOf: 3) countAlive equals: 5.
	self assert: (w breedOf: 4) countAlive equals: 10.
	e push: 3.
	e clearBreed.
	self assert: (w breedOf: 3) countAlive equals: 0.
	self assert: (w breedOf: 4) countAlive equals: 10.
	self assert: e stack size equals: 0.