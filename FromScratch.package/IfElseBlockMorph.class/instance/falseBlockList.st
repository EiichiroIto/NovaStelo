private
falseBlockList
	"Answer an array containing the block sequence false-case nested stack."

	falseBlock
		ifNil: [^ #()]
		ifNotNil: [^ falseBlock blockSequence].

