tests-accessing variable
testDeltaAt
	| ts delta |
	ts := STurtles new breedNo: 3.
	ts create: 2.
	ts headingAt: 1 put: 30.
	ts headingAt: 2 put: 60.
	delta := ts deltaAt: 1.
	self assert: delta equals: (Point r: 1.0 degrees: 30).
	delta := ts deltaAt: 2.
	self assert: delta equals: (Point r: 1.0 degrees: 60).