test
testAppendSymbolWithJump
	| b r |
	b := self newGenerator.
	self assert: b privStream contents isEmpty.
	b appendSymbol: #abc withJump: 12.
	b appendSymbol: #def withJump: 34.
	self assert: b privStream contents size equals: 2.
	r := b privStream contents first.
	self assert: r class equals: ScratchBytecodeSymbolWithJump.
	self assert: r selector equals: #abc.
	self assert: r labelId equals: 12.
	r := b privStream contents second.
	self assert: r class equals: ScratchBytecodeSymbolWithJump.
	self assert: r selector equals: #def.
	self assert: r labelId equals: 34.