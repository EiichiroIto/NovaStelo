test
testTernaryCommandArg1Arg2Arg3
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b ternaryCommand: #abc arg1: 123 arg2: 456 arg3: 789.
	self assert: b privStream contents size equals: 4.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 123.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 456.
	r := b privStream contents third.
	self assert: r class equals: ScratchBytecodeValue.
	self assert: r data equals: 789.
	r := b privStream contents fourth.
	self assert: r class equals: ScratchBytecodeSymbol.
	self assert: r selector equals: #abc.