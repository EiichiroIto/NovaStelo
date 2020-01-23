test
testAppendCall
	| b r |
	b := self newGenerator.
	b subTable: { 'def'->123 } asDictionary.
	self assert: b privStream contents isEmpty.
	b appendCall: 'def'.
	self assert: b privStream contents size equals: 1.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeCall.
	self assert: r subName equals: 'def'.
	self assert: r address equals: 123.