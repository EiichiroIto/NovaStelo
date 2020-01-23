test
testGetY
	| w t |
	w := self newWorld.
	w createPatch: 3.
	w create: 3 turtles: 3.
	w y: 3 at: 1 put: 1.
	w y: 3 at: 2 put: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 1.
	t getY.
	self assert: t pop equals: 1.
	t := self newThread: w.
	t forBreedNo: 3 index: 2.
	t getY.
	self assert: t pop equals: -1.
	t := self newThread: w.
	t forBreedNo: 3 index: 3.
	t getY.
	self assert: t pop equals: 0.
	t := self newThread: w.
	t forPatchId: 3.
	t getY.
	self assert: t pop equals: -1