tests-enumerating
testLivingOnesDo
	| ts |
	ts := STurtles new breedNo: SBreedId turtleBreedNo.
	ts clear.
	ts create: 5.
	self assert: ts countAlive equals: 5.
	ts livingOnesDo: [ :each | ts aliveAt: each put: false ].
	self assert: ts countAlive equals: 0.