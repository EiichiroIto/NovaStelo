accessing
trueBlockList
	"Answer an array containing the block sequence true-case nested stack."

	^ trueBlock ifNil: [ #() ] ifNotNil: [ trueBlock blockSequence ]