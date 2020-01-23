test
testIsBetweenAnd
	| t b r |
	b := self newGenerator.
	r := b is: 10 between: 3 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 10 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 12 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b is: 9 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b is: 13 between: 10 and: 12.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.