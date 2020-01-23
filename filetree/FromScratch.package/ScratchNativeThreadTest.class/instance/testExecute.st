tests-accessing
testExecute
	| t c |
	t := self newThread.
	c := #(push1 pushShort 2 0 #plus #stop).
	t codes: c.
	t execute: 1.
	self assert: t stack size equals: 1.
	self assert: t stack first equals: 3.