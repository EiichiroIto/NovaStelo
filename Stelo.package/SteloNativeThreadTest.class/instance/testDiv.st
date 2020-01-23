test
testDiv
	| t |
	t := self newThread.
	t push: 10.
	t push: 5.
	self assert: t stack size equals: 2.
	t div.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 2.
	t push: 5.
	t push: -10.
	self assert: t stack size equals: 2.
	t div.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -0.5.
	self deny: t isTerminated.
	t push: 5.
	t push: 0.
	t div.
	self assert: t isTerminated.