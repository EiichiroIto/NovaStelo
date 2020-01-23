tests-command
testKillAt
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 3.
	self assert: (ts aliveAt: 1).
	self assert: (ts aliveAt: 2).
	self assert: (ts aliveAt: 3).
	ts killAt: 1.
	ts killAt: 3.
	self assert: (ts aliveAt: 1) not.
	self assert: (ts aliveAt: 2).
	self assert: (ts aliveAt: 3) not.