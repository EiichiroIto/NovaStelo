other
asBlockTuple
	"Answer a tuple (Array) describing this block and its event name."

	^ Array with: self class name with: self eventName
