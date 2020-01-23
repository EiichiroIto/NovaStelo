test
testRot
	| t |
	t := self newThread.
	self assert: t stack size equals: 0.
	t push: 10.
	t push: 20.
	t push: 30.
	self assert: t stack size equals: 3.
	t rot.
	self assert: t stack size equals: 3.
	self assert: t pop equals: 10.
	self assert: t pop equals: 30.
	self assert: t pop equals: 20.