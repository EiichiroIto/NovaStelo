test
testExp10
	| t |
	t := self newThread.
	t push: 0.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 1.
	t push: 2.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 100.
	t push: -1.
	self assert: t stack size equals: 1.
	t exp10.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.1.