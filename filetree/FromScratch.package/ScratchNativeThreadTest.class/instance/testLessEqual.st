tests-arithmetic ops
testLessEqual
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 0.
	t push: -10.
	t push: -10.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: -10.
	t push: 10.
	self assert: t stack size equals: 2.
	t lessEqual.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.