test
testRounded
	| t |
	t := self newThread.
	t push: 1.4.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 1.
	t push: 1.5.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: 2.
	t push: -1.5.
	self assert: t stack size equals: 1.
	t rounded.
	self assert: t stack size equals: 1.
	self assert: t pop equals: -2.