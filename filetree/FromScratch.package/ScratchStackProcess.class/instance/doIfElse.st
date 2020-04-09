special ops
doIfElse
	"Evaluate the current expression (which must be an if-then-else)."

	| block arguments argExp |
	block := stackFrame expression.
	arguments := stackFrame arguments.

	"evaluate the arg if we haven't already."
	arguments isEmpty
		ifTrue: [ argExp := block argumentAt: 1.
			^ self pushStackFrame: (ScratchStackFrame new expression: argExp) ].

	"we can pop this expression off the stack either way"
	self popStackFrame.
	arguments first
		ifTrue: [ self
				pushStackFrame: (ScratchStackFrame new expression: block trueBlockList) ]
		ifFalse: [ self
				pushStackFrame: (ScratchStackFrame new expression: block falseBlockList) ]