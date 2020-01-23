test
testSqrt
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 2.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2 sqrt.
	self deny: t isTerminated.
	t push: -5.
	self assert: t stack size equals: 1.
	t sqrt.
	self assert: t isTerminated.