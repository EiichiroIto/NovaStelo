test
testDirection
	| t |
	t := self newThread.
	t forPatchId: 1.
	t push: 0.
	t push: 0.
	t direction.
	self assert: t pop equals: 90.
	t push: 1.
	t push: 1.
	t direction.
	self assert: t pop equals: 45.
	t push: 0.
	t push: 1.
	t direction.
	self assert: t pop equals: 90.
	t push: 0.
	t push: -1.
	t direction.
	self assert: t pop equals: -90.
	t push: -1.
	t push: 1.
	t direction.
	self assert: t pop equals: 135.
	t push: -1.
	t push: -1.
	t direction.
	self assert: t pop equals: 225.
	t push: 1.
	t push: -1.
	t direction.
	self assert: t pop equals: 360 - 45.