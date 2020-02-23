test
testSizeOf
	| c t |
	c := SPluginWorld new.
	c createPatch: 11.
	self assert: (c sizeOf: 2) equals: 121.
	t := STurtles new breedNo: 3.
	c addBreed: t.
	self assert: (c countAliveOf: 3) equals: 0.
	c create: 3 turtles: 5.
	self assert: (c sizeOf: 3) equals: 100.