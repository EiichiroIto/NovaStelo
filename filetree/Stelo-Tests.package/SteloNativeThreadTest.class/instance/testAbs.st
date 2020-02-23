test
testAbs
	| t |
	t := self newThread.
	t push: 10.
	self assert: t stack size equals: 1.
	t abs.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 10.
	t push: -20.
	self assert: t stack size equals: 1.
	t abs.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 20.