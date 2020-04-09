private
evaluateSequence
	"Requires that the current expression be a collection of blocks.  Evaluates the block in the current expression (which is a list of blocks) at the given pc."

	| blocks pc |
	blocks := stackFrame expression.
	pc := stackFrame pc.
	pc > blocks size
		ifTrue: [ self popStackFrame ]
		ifFalse: [ stackFrame pc: pc + 1.
			self
				pushStackFrame: (ScratchStackFrame new expression: (blocks at: pc)) ]