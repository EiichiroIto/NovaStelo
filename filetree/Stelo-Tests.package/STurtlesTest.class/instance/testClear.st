tests-accessing
testClear
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts create: 100.
	self assert: ts countAlive equals: 100.
	ts clear.
	self assert: ts countAlive equals: 0.