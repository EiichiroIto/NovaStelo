test
testXyOf
	| w t |
	w := self newWorld.
	t := self newThread: w.
	w createPatch: 4.
	t push: 11.
	t xyOf.
	self assert: t pop equals: 0.
	self assert: t pop equals: 0.
	t push: 1.
	t xyOf.
	self assert: t pop equals: -2.
	self assert: t pop equals: -2.
	t push: 16.
	t xyOf.
	self assert: t pop equals: 1.
	self assert: t pop equals: 1.
	t push: 7.
	t xyOf.
	self assert: t pop equals: -1.
	self assert: t pop equals: 0.