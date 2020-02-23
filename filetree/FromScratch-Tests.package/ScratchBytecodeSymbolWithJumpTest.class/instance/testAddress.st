test
testAddress
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c address isNil.
	c address: 123.
	self assert: c address equals: 123.