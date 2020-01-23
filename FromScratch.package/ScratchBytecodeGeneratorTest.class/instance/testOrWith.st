test
testOrWith
	| t b r |
	b := self newGenerator.
	r := b or: true with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: true with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: false with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b or: false with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.