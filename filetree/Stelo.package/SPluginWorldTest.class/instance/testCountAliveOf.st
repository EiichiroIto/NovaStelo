test
testCountAliveOf
	| c t |
	c := SPluginWorld new.
	c createPatch: 10.
	self assert: (c countAliveOf: 2) equals: 100.
	self assert: (c countAliveOf: 3) equals: 0.
	t := STurtles new breedNo: 3.
	c addBreed: t.
	self assert: (c countAliveOf: 3) equals: 0.
	c create: 3 turtles: 50.
	self assert: (c countAliveOf: 3) equals: 50.
	c create: 3 turtles: 5.
	self assert: (c countAliveOf: 3) equals: 55