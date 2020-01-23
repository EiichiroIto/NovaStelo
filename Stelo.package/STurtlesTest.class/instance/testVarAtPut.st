tests-accessing variable
testVarAtPut
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 2.
	ts var: STurtleVarDef xVarNo at: 1 put: 2.
	ts var: STurtleVarDef xVarNo at: 2 put: 5.
	ts var: STurtleVarDef headingVarNo at: 1 put: 200.
	ts var: STurtleVarDef headingVarNo at: 2 put: 400.
	ts var: STurtleVarDef colorVarNo at: 1 put: 100.
	ts var: STurtleVarDef colorVarNo at: 2 put: 200.
	self assert: (ts xAt: 1) equals: 2.
	self assert: (ts xAt: 2) equals: 5.
	self assert: (ts headingAt: 1) equals: 200.
	self assert: (ts headingAt: 2) equals: 40.
	self assert: (ts colorAt: 1) equals: 100.
	self assert: (ts colorAt: 2) equals: 200 \\ SColorList colors size.