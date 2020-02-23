test
testSetFloatBreedIdValue
	| c x |
	c := SteloLibCall new.
	c setupBreed: 3.
	c create: 3 turtles: 1.
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 1.
	self assert: x closeTo: 0.
	c
		setFloat: STurtleVarDef xVarNo
		breed: 3
		id: 1
		value: 1.0.
	x := c getFloat: STurtleVarDef xVarNo breed: 3 id: 1.
	self assert: x closeTo: 1.
	c
		setFloat: SObserverVarDef ticksVarNo
		breed: SBreedId observerBreedNo
		id: 0
		value: 120.
	x := c
		getFloat: SObserverVarDef ticksVarNo
		breed: SBreedId observerBreedNo
		id: 0.
	self assert: x equals: 120.
	c
		setFloat: SObserverVarDef ticksVarNo
		breed: SBreedId observerBreedNo
		id: 0
		value: 10.
	x := c
		getFloat: SObserverVarDef ticksVarNo
		breed: SBreedId observerBreedNo
		id: 0.
	self assert: x equals: 10