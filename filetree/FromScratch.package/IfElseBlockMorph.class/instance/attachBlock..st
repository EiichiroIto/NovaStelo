private
attachBlock: aBlockMorph
	"Attach the given block to me. Assume the block has been positioned correctly."

	| y |
	self addMorph: aBlockMorph.
	y := aBlockMorph top.
	y <= (self top + elseBarY) ifTrue: [trueBlock := aBlockMorph. ^ self].
	y <= (self bottom - CBlockBracketThickness) ifTrue: [falseBlock := aBlockMorph. ^ self].
	nextBlock := aBlockMorph.

