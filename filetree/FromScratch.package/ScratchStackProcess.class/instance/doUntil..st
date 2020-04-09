special ops
doUntil: terminatingBoolean
	"Evaluates the current while or until loop expression until the loop condition evaluates to the boolean terminating value."

	| args block |
	block := stackFrame expression.
	args := stackFrame arguments.

	"Evaluate the condition if we haven't yet."
	args isEmpty
		ifTrue: [ ^ self evaluateNextArgument ].

	"If the condition matches the terminatingBoolean, pop this frame and we're done."
	args first = terminatingBoolean
		ifTrue: [ ^ self popStackFrame ].

	"Set up for an iteration of the while loop.  We need to:
		1.  evaluate the body
		2.  yield to another process
		3.  evaluate the while/until block again
	Push these onto stack in reverse order."

	"3.  evaluate the while/until block again"
	"(We remove the current frame and replace it with one that will force the argument to be re-evaluated.)"
	self popStackFrameNoUnhightlight.
	self pushStackFrame: (ScratchStackFrame new expression: block).

	"2.  yield to another process"
	self pushStackFrame: (ScratchStackFrame new shouldYield: true).

	"1.  evaluate the body"
	self
		pushStackFrame: (ScratchStackFrame new expression: block firstBlockList)