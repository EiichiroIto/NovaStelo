test
testCodeSize
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c codeSize equals: 4.