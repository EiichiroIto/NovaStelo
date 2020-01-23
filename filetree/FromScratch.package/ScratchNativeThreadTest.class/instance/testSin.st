tests-arithmetic ops
testSin
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 90.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 180.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 270.
	self assert: t stack size equals: 1.
	t sin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.