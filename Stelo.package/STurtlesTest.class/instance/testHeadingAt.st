tests-accessing variable
testHeadingAt
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	ts headingAt: 1 put: 10.
	ts headingAt: 2 put: 20.
	self assert: (ts headingAt: 1) equals: 10.
	self assert: (ts headingAt: 2) equals: 20