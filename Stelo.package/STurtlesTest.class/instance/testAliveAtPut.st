tests-accessing variable
testAliveAtPut
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 3.
	self assert: ts countAlive equals: 3.
	ts aliveAt: 1 put: false.
	ts aliveAt: 2 put: false.
	self assert: ts countAlive equals: 1.
	ts aliveAt: 2 put: true.
	self assert: ts countAlive equals: 2.