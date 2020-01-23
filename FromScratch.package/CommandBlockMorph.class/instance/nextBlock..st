private
nextBlock: aBlock
	"Add the given block as the block following me. Delete old nextBlock, if any."

	self nextBlock ifNotNil: [self nextBlock delete].
	self addMorph: aBlock.
