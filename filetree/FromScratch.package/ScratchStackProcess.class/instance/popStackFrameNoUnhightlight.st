private
popStackFrameNoUnhightlight
	"Pops the current stack frame off the top of the stack, so that the next one becomes the current frame. Do not add a stack frame to unhighlight this block. Use this method when a block will re-evaluated, such 'wait until'."

	stackFrame := stackFrame parentFrame