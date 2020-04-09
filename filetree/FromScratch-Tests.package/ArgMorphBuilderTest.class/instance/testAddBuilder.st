test
testAddBuilder
	| b |
	b := self newBuilder.
	b add: $a builder: 123.
	b add: $b builder: 456.
	self assert: (b privDict at: $a) equals: 123.
	self assert: (b privDict at: $b) equals: 456.
	self should: [ b add: $b builder: 789 ] raise: Error