tests-accessing
testEvaluate
	| t c x |
	t := self newThread.
	c := #(push1 pushShort 2 0 #plus #stop).
	t codes: c.
	x := t evaluate: 1.
	self assert: x equals: 3.