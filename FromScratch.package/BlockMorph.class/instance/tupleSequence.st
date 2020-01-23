block enumerating
tupleSequence
	"Answer a sequence of tuples (Array) describing this stack of blocks."

	^ self blockSequence collect: [:b | b asBlockTuple]
