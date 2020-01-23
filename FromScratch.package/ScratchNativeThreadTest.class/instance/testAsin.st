tests-arithmetic ops
testAsin
	| t |
	t := self newThread.
	t push: 0.5.
	self assert: t stack size equals: 1.
	t asin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: 30.
	t push: -10.
	self assert: t stack size equals: 1.
	t asin.
	self assert: t stack size equals: 1.
	self assert: t pop closeTo: -90.