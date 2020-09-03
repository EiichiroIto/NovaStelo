special ops
doReturn
	"Evaluates its argument, and returns the value to the frame from which the current method was called."

	| value args |
	args := stackFrame arguments.

	"Evaluate the argument, if necessary."
	args size < stackFrame expression argumentCount
		ifTrue: [ ^ self evaluateNextArgument ].

	"Remember the return value."
	value := args notEmpty
		ifTrue: [ args first ]
		ifFalse: [ nil ].

	"Pop until we're out of frames to pop, or we hit a return marker."
	[ stackFrame isNil ] whileFalse: [ self popStackFrame ].
	stackFrame
		ifNotNil: [ self returnValueToParentFrame: value.
			self popStackFrame ]