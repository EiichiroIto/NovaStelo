test
testDivideBy
	| t b r |
	b := self newGenerator.
	r := b divide: 100 by: 2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 50.

	b := self newGenerator.
	r := b divide: 12 by: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 4.

	b := self newGenerator.
	r := b divide: 10 by: -2.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -5.

	b := self newGenerator.
	r := b divide: 1 by: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.2.

	b := self newGenerator.
	r := b divide: 2 by: -4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -0.5.