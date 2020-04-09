special ops
callSubroutine
	| block args eventName procs sub |
	block := stackFrame expression.
	args := stackFrame arguments.
	"first time: send the event and collect a list of processes"
	args isEmpty
		ifTrue: [ eventName := block args first asString.
			sub := block receiver subHatBlockNamed: eventName.
			procs := {sub startProcess} ]
		ifFalse: [ procs := args first ].
	"if all processes have stopped, pop this frame and we're done."
	(procs allSatisfy: [ :p | p isRunning not ])
		ifTrue: [ ^ self popStackFrame ].
	"Set up the wait loop. We need to: 
	1. yield to another process 
	2. evaluate the termination expression again 
	Push these onto stack in reverse order."
	"2. evaluate this block again"
	"(Remove the current frame and replace it with one that will force the 
	termination expression to be re-evaluated.)"
	self popStackFrameNoUnhightlight.
	self
		pushStackFrame:
			(ScratchStackFrame new
				expression: block;
				addArgument: procs).
	"1. yield to another process"
	self pushStackFrame: (ScratchStackFrame new shouldYield: true)