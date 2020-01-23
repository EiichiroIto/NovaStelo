tests-arithmetic ops
testExp
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 2.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2 exp.
	t push: -1.
	self assert: t stack size equals: 1.
	t exp.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1 / 1 exp.