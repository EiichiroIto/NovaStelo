test
testLessThan
	| t b r |
	b := self newGenerator.
	r := b less: 12 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: -10 than: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b less: 5 than: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b less: -2.5 than: -2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.