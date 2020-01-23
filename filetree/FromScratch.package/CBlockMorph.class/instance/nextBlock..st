private
nextBlock: aBlockMorph
	"Add the given block as the block following me. Delete old nextBlock, if any."

	self nextBlock ifNotNil: [self nextBlock delete].
	nextBlock := aBlockMorph.
	aBlockMorph ifNotNil: [self addMorph: aBlockMorph].
