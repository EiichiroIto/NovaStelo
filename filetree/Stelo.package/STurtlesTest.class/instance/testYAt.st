tests-accessing variable
testYAt
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	self assert: (ts yAt: 1) equals: 0.
	self assert: (ts yAt: 2) equals: 0.
	ts yAt: 1 put: 10.
	ts yAt: 2 put: 20.
	self assert: (ts yAt: 1) equals: 10.
	self assert: (ts yAt: 2) equals: 20