tests-accessing
testDefaultColor
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	self assert: (ts defaultColor between: 1 and: 140).