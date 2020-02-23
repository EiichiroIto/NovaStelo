test
testId
	| c |
	c := self newLabel: 1.
	self assert: c id equals: 1.
	c id: 20.
	self assert: c id equals: 20.