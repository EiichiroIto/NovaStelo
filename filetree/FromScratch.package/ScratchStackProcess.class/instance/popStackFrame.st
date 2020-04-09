private
popStackFrame
	"Pops the current stack frame off the top of the stack, so that the next one becomes the current frame."

	| command frame unlightFrame |
	frame := stackFrame.
	stackFrame := stackFrame parentFrame.
	command := frame expression.
	self class blockHighlightMSecs > 0
		ifTrue: [ (frame shouldUnlight not and: [ command isKindOf: BlockMorph ])
				ifTrue: [ "We push a new frame for unlighting this command."
					unlightFrame := ScratchStackFrame new
						expression: command;
						shouldUnlight: true.
					self pushStackFrame: unlightFrame ] ]