private
applyPrimitive
	"Apply the current expression (which must be a CommandBlock) to the current arguments (which must all have been evaluated)."

	| value |
	value := stackFrame expression evaluateWithArgs: stackFrame arguments.
	"save the return value in the parent frame before popStackFrame because popFrame adds a frame while single-stepping"
	self returnValueToParentFrame: value.
	self popStackFrame