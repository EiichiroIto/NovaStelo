private
evaluateNextArgument
	"Evaluates the next argument of the command in expression.  Requires that expression be a block that takes more args than are already evaluated in the current stack frame."

	| argumentExpression |
	argumentExpression := stackFrame expression
		argumentAt: stackFrame arguments size + 1.
	self
		pushStackFrame: (ScratchStackFrame new expression: argumentExpression)