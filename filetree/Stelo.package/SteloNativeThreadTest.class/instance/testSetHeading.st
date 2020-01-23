test
testSetHeading
	| w t h |
	w := self newWorld.
	w create: 3 turtles: 2.
	h := (w breedOf: 3) headingAt: 2.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	self assert: t stack size equals: 0.
	t push: 10.
	t setHeading.
	self assert: t stack size equals: 0.
	self assert: ((w breedOf: 3) headingAt: 1) equals: 10.
	self assert: ((w breedOf: 3) headingAt: 2) equals: h.
	t push: 20.
	t setHeading.
	self assert: t stack size equals: 0.
	self assert: ((w breedOf: 3) headingAt: 1) equals: 20.
	self assert: ((w breedOf: 3) headingAt: 2) equals: h.