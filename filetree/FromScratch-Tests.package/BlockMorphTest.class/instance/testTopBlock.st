test
testTopBlock
	| b1 b2 b3 |
	b1 := self newBlock.
	b2 := self newBlock.
	b3 := self newBlock.
	b1 nextBlock: b2.
	b2 nextBlock: b3.
	self assert: b1 topBlock equals: b1.
	self assert: b2 topBlock equals: b1.
	self assert: b3 topBlock equals: b1