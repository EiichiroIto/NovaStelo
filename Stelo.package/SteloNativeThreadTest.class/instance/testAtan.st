test
testAtan
	| t |
	t := self newThread.
	t push: 1.
	self assert: t stack size equals: 1.
	t atan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 45.
	t push: -10.
	self assert: t stack size equals: 1.
	t atan.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -45.