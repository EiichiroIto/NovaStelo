tests-accessing
testCountAlive
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts create: 10.
	self assert: ts countAlive equals: 10.
	ts aliveAt: 4 put: false.
	ts aliveAt: 8 put: false.
	self assert: ts countAlive equals: 8.