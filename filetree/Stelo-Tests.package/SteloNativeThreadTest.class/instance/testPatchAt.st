test
testPatchAt
	| w t |
	w := self newWorld.
	t := self newThread: w.
	w createPatch: 4.
	t push: 0.
	t push: 0.
	t patchAt.
	self assert: t pop equals: 11.
	t push: -2.
	t push: -2.
	t patchAt.
	self assert: t pop equals: 1.
	t push: 1.
	t push: 1.
	t patchAt.
	self assert: t pop equals: 16.
	t push: 0.
	t push: -1.
	t patchAt.
	self assert: t pop equals: 7.