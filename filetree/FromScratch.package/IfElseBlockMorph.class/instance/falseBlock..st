private
falseBlock: aBlockMorph
	"Add the given block as my false nested block sequence. Delete the old nested blocks, if any."

	falseBlock ifNotNil: [falseBlock delete].
	falseBlock := aBlockMorph.
	aBlockMorph ifNotNil: [self addMorph: aBlockMorph].
