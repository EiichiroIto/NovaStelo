private
asBlockTuple
	"Answer a tuple (Array) describing this block and its arguments."

	^ Array with: #readVariable with: commandSpec
