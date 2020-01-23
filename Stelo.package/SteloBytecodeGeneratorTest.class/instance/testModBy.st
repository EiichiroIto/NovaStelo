test
testModBy
	| t b r |
	b := self newGenerator.
	r := b mod: 12 by: 3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b mod: 10 by: -3.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: -2.

	b := self newGenerator.
	r := b mod: 1 by: 5.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b mod: -2 by: 4.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 2.