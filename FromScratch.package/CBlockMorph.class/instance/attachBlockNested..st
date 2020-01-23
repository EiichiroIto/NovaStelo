private
attachBlockNested: aBlockMorph
	"Attach the given block to me. Assume the block has been positioned correctly."

	(stretchHeight = 0)
			ifTrue: [self position: (aBlockMorph left)@(aBlockMorph top - self height + 4)].
	self addMorph: aBlockMorph.
	(stretchHeight = 0)
		ifTrue: [self bottomBlock nextBlock: aBlockMorph]
		ifFalse: [nestedBlock := aBlockMorph].
