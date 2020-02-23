test
testVarsBreedAt
	| w ret |
	w := self newWorld.
	ret := w varsBreed: SBreedId turtleBreedNo at: 1.
	self assert: ret isArray.
	self assert: ret notEmpty.
	self assert: ret first isArray.
	self assert: ret first size equals: 2