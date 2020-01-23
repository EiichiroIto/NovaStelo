test
testNullaryCommand
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b nullaryCommand: #abc.
	self assert: b privStream contents size equals: 1.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.