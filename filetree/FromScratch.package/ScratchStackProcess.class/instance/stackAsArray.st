private
stackAsArray
	"Returns an array describing the contents of the stack.  Useful for debugging."

	| frame collection |
	frame := stackFrame.
	collection := OrderedCollection new.
	[ frame isNil ]
		whileFalse: [ collection add: frame expression.
			frame := frame parentFrame ].
	^ collection asArray