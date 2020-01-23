test
testLog
	| t |
	t := self newThread.
	t push: 1.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 0.
	t push: 100.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 2.
	t push: 0.1.
	self assert: t stack size equals: 1.
	t log.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -1.