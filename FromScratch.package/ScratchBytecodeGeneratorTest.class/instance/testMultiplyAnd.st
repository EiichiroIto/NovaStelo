test
testMultiplyAnd
	| t b r |
	b := self newGenerator.
	r := b multiply: 12 and: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 36.

	b := self newGenerator.
	r := b multiply: 10 and: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -30.

	b := self newGenerator.
	r := b multiply: 1.5 and: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 7.5.

	b := self newGenerator.
	r := b multiply: -2 and: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 8.