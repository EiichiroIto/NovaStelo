tests
testCountAliveOfBreedNo
	| w |
	w := self newWorld.
	w create: 3 turtles: 10.
	w newBreed.
	w create: 4 turtles: 15.
	self assert: (w countAliveOf: 3) equals: 10.
	self assert: (w countAliveOf: 4) equals: 15.
	w createPatch: 10.
	self assert: (w countAliveOf: 2) equals: 100.