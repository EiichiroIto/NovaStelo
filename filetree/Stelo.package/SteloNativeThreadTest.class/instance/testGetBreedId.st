test
testGetBreedId
	| w t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 2.

	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t getBreedId.
	self assert: t pop equals: 3.

	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t getBreedId.
	self assert: t pop equals: 3.

	t := self newThread: w.
	t forPatchId: 3.
	t getBreedId.
	self assert: t pop equals: 2.

	t := self newThread: w.
	t forObserver.
	t getBreedId.
	self assert: t pop equals: 1.