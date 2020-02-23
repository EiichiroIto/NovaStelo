test
testBlockSequence
	| b1 b2 b3 |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	self
		assertCollection: b1 blockSequence
		equals:
			{b1.
			b2.
			b3}