private
attachBlock: aBlockMorph
	"Attach the given block to me. Assume the block has been positioned correctly."

	self addMorph: aBlockMorph.
	aBlockMorph top >= (self bottom - CBlockBracketThickness)
		ifTrue: [nextBlock := aBlockMorph]
		ifFalse: [nestedBlock := aBlockMorph].
