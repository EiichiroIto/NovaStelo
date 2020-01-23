test
testAddVariableNameBreedNo
	| c x |
	c := SteloLibCall new.
	x := c addVariable: 10 breed: SBreedId patchBreedNo.
	self assert: x.
	x := c addVariable: 10 breed: SBreedId patchBreedNo.
	self deny: x