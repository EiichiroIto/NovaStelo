test
testGetWordBreedId
	| c x |
	c := SteloLibCall new.
	c setupBreed: 3.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 1.
	self assert: x equals: 0.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 2.
	self assert: x equals: 0.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 3.
	self assert: x equals: 0.
	c create: 3 turtles: 2.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 1.
	self assert: x equals: 1.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 2.
	self assert: x equals: 1.
	x := c getByte: STurtleVarDef flagVarNo breed: 3 id: 3.
	self assert: x equals: 0.