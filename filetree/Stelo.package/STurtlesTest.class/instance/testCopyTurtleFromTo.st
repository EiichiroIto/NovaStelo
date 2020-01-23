tests-accessing
testCopyTurtleFromTo
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts create: 2.
	ts xAt: 1 put: 2.
	ts yAt: 1 put: 3.
	ts headingAt: 1 put: 30.
	ts headingAt: 2 put: 60.
	self assert: (ts xAt: 1) equals: 2.
	self assert: (ts yAt: 1) equals: 3.
	self assert: (ts xAt: 2) equals: 0.
	self assert: (ts yAt: 2) equals: 0.
	self assert: (ts headingAt: 1) equals: 30.
	self assert: (ts headingAt: 2) equals: 60.
	ts copyTurtleFrom: 1 to: 2.
	self assert: (ts xAt: 1) equals: 2.
	self assert: (ts yAt: 1) equals: 3.
	self assert: (ts xAt: 2) equals: 2.
	self assert: (ts yAt: 2) equals: 3.
	self assert: (ts headingAt: 1) equals: 30.
	self assert: (ts headingAt: 2) equals: 30