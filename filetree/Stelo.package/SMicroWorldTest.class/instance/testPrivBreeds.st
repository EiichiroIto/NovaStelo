tests-private
testPrivBreeds
	| w |
	w := self newWorld.
	self assert: w privBreeds isArray.
	self assert: (w privBreeds at: 1) class equals: SObserver.
	self assert: (w privBreeds at: 2) class equals: SPatches.
	self assert: (w privBreeds at: 3) class equals: STurtles.