test
testGetFloatBreedId
	| c x |
	c := SteloLibCall new.
	c createPatch: 10.
	x := c getFloat: SObserverVarDef widthVarNo breed: SBreedId observerBreedNo id: 1.
	self assert: x equals: 10.