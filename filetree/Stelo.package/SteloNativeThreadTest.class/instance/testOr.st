test
testOr
	| t |
	t := self newThread.
	t push: false.
	t push: false.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t stack first equals: 0.
	t pop.
	t push: false.
	t push: true.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: true.
	t push: false.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: true.
	t push: true.
	self assert: t stack size equals: 2.
	t or.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.