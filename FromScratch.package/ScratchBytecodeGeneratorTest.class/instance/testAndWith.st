test
testAndWith
	| t b r |
	b := self newGenerator.
	r := b and: true with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 1.

	b := self newGenerator.
	r := b and: true with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b and: false with: true.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.

	b := self newGenerator.
	r := b and: false with: false.
	self assert: r isNil.
	t := self newThread.
	t codes: b code.
	self assert: (t evaluate: 1) equals: 0.