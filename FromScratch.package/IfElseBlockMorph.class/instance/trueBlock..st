private
trueBlock: aBlockMorph
	"Add the given block as my true nested block sequence. Delete the old nested blocks, if any."

	trueBlock ifNotNil: [trueBlock delete].
	trueBlock := aBlockMorph.
	aBlockMorph ifNotNil: [self addMorph: aBlockMorph].
