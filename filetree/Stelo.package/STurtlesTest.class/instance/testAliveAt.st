tests-accessing variable
testAliveAt
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	self assert: ts countAlive equals: 2.
	ts aliveAt: 1 put: false.
	self assert: ts countAlive equals: 1.