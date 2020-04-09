private
pushStackFrame: aScratchStackFrame
	"Pushes the given new stack frame onto the top of the stack, so that it becomes the current stack frame."

	aScratchStackFrame parentFrame: stackFrame.
	stackFrame := aScratchStackFrame