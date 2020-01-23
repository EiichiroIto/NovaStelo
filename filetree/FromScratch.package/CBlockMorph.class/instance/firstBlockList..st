private
firstBlockList: aBlockMorph
	"Add the given block as my first nested block sequence. Delete the old nested blocks, if any."

	nestedBlock ifNotNil: [nestedBlock delete].
	nestedBlock := aBlockMorph.
	aBlockMorph ifNotNil: [self addMorph: aBlockMorph].
