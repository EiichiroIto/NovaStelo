test
testCodeSize
	| c |
	c := self newBytecode.
	self assert: c codeSize equals: 1.