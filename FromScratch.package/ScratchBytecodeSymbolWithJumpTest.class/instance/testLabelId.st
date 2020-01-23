test
testLabelId
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c labelId equals: 1.
	c labelId: 123.
	self assert: c labelId equals: 123.