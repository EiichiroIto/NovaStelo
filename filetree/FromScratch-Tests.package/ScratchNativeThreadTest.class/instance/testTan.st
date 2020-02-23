tests-arithmetic ops
testTan
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 60.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 3 sqrt.
	t push: 30.
	self assert: t stack size equals: 1.
	t tan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: (1 / 3 sqrt).
