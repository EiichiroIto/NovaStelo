tests-accessing variable
testPenDownAt
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	self assert: (ts penDownAt: 1) equals: false.
	self assert: (ts penDownAt: 2) equals: false.
	ts penDownAt: 1 put: true.
	ts penDownAt: 2 put: false.
	self assert: (ts penDownAt: 1) equals: true.
	self assert: (ts penDownAt: 2) equals: false