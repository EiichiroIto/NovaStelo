special ops
doRepeat
	"Handles one iteration of a repeat block."

	| arguments argExp block counter frame |
	block := stackFrame expression.
	arguments := stackFrame arguments.

	"If we haven't done so yet, evaluate the argument to repeat."
	arguments size < 1
		ifTrue: [ argExp := block argumentAt: 1.
			^ self pushStackFrame: (ScratchStackFrame new expression: argExp) ].

	"If the number of times to repeat is 0, then we're done."
	counter := arguments first asNumberNoError.
	counter <= 0
		ifTrue: [ ^ self popStackFrame ].

	"Pop this instruction from the stack."
	self popStackFrameNoUnhightlight.

	"At top of stack should now be:
		1.  evaluate body of repeat block.
		2.  yield.
		3.  evaluate repeat block with decremented counter value.
	Need to add these to the stack in reverse order."

	"3.  evaluate repeat block with decremented counter value."
	frame := ScratchStackFrame new
		expression: block;
		addArgument: counter - 1.
	self pushStackFrame: frame.

	"2.  yield."
	self pushStackFrame: (ScratchStackFrame new shouldYield: true).

	"1.  evaluate body of repeat block."
	self
		pushStackFrame: (ScratchStackFrame new expression: block firstBlockList)