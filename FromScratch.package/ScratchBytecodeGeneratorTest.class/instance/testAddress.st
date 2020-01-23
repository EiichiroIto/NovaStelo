test
testAddress
	| b |
	b := self newGenerator.
	self assert: b address equals: 1.
	b address: 100.
	self assert: b address equals: 100.