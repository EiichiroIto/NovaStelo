test
testDoIfElse
	| r b t i |
	b := self newGenerator.
	b appendValue: 1.
	b appendValue: false.
	i := b doIfBegin: nil.
	b appendValue: 1.
	b appendSymbol: #plus.
	i := b doIfElse: i.
	b appendValue: 2.
	b appendSymbol: #plus.
	b doIfEnd: i.
	t := self newThread.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 3.

	b := self newGenerator.
	b appendValue: 1.
	b appendValue: true.
	i := b doIfBegin: nil.
	b appendValue: 1.
	b appendSymbol: #plus.
	i := b doIfElse: i.
	b appendValue: 2.
	b appendSymbol: #plus.
	b doIfEnd: i.
	t := self newThread.
	t codes: b code.
	r := t evaluate: 1.
	self assert: r equals: 2.