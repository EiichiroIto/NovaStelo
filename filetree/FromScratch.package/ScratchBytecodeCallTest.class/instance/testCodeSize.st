test
testCodeSize
	| c |
	c := self newCall: 'abc'.
	self assert: c codeSize equals: 4.