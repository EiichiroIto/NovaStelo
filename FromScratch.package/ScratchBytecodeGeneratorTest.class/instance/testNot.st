test
testNot
	| t b r |
	b := self newGenerator.
	r := b not: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b not: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.