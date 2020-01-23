test
testSubNameAddress
	| c |
	c := self newCall: 'abc' address: 123.
	self assert: c subName equals: 'abc'.
	self assert: c address equals: 123.
	c := self newCall: 'def' address: 456.
	self assert: c subName equals: 'def'.
	self assert: c address equals: 456.