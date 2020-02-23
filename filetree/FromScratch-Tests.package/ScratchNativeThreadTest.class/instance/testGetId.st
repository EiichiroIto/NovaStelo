tests-variable ops
testGetId
	| t |
	t := self newThread.
	t privId: 10.
	self assert: t stack size equals: 0.
	t getId.
	self assert: t pop equals: 10.