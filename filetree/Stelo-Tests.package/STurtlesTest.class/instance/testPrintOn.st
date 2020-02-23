tests-printing
testPrintOn
	| ts |
	ts := STurtles new breedNo: 3.
	self assert: ts asString equals: 'Turtles(0)'.
	ts create: 10.
	self assert: ts asString equals: 'Turtles(10)'.