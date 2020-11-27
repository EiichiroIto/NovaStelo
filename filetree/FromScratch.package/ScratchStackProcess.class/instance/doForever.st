special ops
doForever
	"Executes one iteration of a forever loop."

	"Right now, the forever special form is at the top of the stack.  We're going to add two more things on top of this:  (1) a frame for evaluating the blocks in the forever block, and (2) a frame that just results in yielding control.  That way we'll evaluate the contents of the block, give up control, and do it all again."

	| blocks |
	"Remember blocks to evaluate before we clobber the stack."
	blocks := stackFrame expression firstBlockList.

	"When we're all done with these blocks, we want to yield."
	self pushStackFrame: (ScratchStackFrame new shouldYield: true).

	"First, we want to evaluate the blocks inside the loop."
	self pushStackFrame: (ScratchStackFrame new expression: blocks)