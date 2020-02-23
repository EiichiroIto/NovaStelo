tests-misc ops
testDup
	| t |
	t := self newThread.
	self assert: t stack size equals: 0.
	t push: 10.
	self assert: t stack size equals: 1.
	t dup.
	self assert: t stack size equals: 2.
	self assert: t pop equals: 10.
	self assert: t pop equals: 10.
	self assert: t stack size equals: 0.