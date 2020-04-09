special ops
doIf
	"Evaluate the current expression (which must be an if)."

	| block arguments argExp |
	block := stackFrame expression.
	arguments := stackFrame arguments.

	"Evaluate the arg if we haven't already."
	arguments isEmpty
		ifTrue: [ argExp := block argumentAt: 1.
			^ self pushStackFrame: (ScratchStackFrame new expression: argExp) ].

	"We can pop this expression off the stack either way."
	self popStackFrame.

	"If the predicate was false, just return."
	arguments first
		ifFalse: [ ^ self ].

	"Since the predicate was true, evaluate the body of the if."
	self
		pushStackFrame: (ScratchStackFrame new expression: block firstBlockList)