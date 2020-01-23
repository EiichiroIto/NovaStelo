tests-arithmetic ops
testAnd
	| t |
	t := self newThread.
	t push: false.
	t push: false.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: false.
	t push: true.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: true.
	t push: false.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: true.
	t push: true.
	self assert: t stack size equals: 2.
	t and.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.