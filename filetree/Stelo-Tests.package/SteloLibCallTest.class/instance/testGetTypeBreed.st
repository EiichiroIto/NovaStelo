test
testGetTypeBreed
	| c t |
	c := SteloLibCall new.
	c setupBreed: SBreedId turtleBreedNo.
	t := c getType: STurtleVarDef colorVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: STurtleVarDef flagVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: STurtleVarDef xVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: STurtleVarDef yVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: STurtleVarDef headingVarNo breed: SBreedId turtleBreedNo.
	self assert: t equals: SteloLibCall float.
	t := c getType: SPatchVarDef colorVarNo breed: SBreedId patchBreedNo.
	self assert: t equals: SteloLibCall byte.
	t := c getType: SPatchVarDef xVarNo breed: SBreedId patchBreedNo.
	self assert: t equals: SteloLibCall computedFloat.
	t := c getType: SPatchVarDef yVarNo breed: SBreedId patchBreedNo.
	self assert: t equals: SteloLibCall computedFloat.
	t := c getType: SPatchVarDef screenVarNo breed: SBreedId patchBreedNo.
	self assert: t equals: SteloLibCall byte.