test
testDoUntilBegin
	| b t i |
	b := self newGenerator.
	i := b doUntilBegin.
	b appendValue: true.
	b doUntilEnd: nil id: i.
	t := self newThread.
	t codes: b code.
	t execute: 1.