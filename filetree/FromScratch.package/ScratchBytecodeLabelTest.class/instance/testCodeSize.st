test
testCodeSize
	| c |
	c := self newLabel: 1.
	self assert: c codeSize equals: 0.