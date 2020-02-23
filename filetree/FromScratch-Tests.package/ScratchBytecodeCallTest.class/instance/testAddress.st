test
testAddress
	| c |
	c := self newCall: 'abc'.
	self assert: c address isNil.
	c address: 123.
	self assert: c address equals: 123.
	c address: 456.
	self assert: c address equals: 456.