tests-misc ops
testDrop
	| t |
	t := self newThread.
	self assert: t stack size equals: 0.
	t push: 10.
	self assert: t stack size equals: 1.
	t drop.
	self assert: t stack size equals: 0.