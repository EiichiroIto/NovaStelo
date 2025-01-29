Class {
	#name : 'ScratchStackProcess',
	#superclass : 'Object',
	#instVars : [
		'topBlock',
		'errorFlag',
		'readyToYield',
		'stackFrame',
		'readyToTerminate'
	],
	#category : 'FromScratch-Process',
	#package : 'FromScratch',
	#tag : 'Process'
}

{ #category : 'accessing' }
ScratchStackProcess class >> blockHighlightMSecs [
	^ 1
]

{ #category : 'private' }
ScratchStackProcess >> applyPrimitive [
	"Apply the current expression (which must be a CommandBlock) to the current arguments (which must all have been evaluated)."

	| value |
	value := stackFrame expression evaluateWithArgs: stackFrame arguments.
	"save the return value in the parent frame before popStackFrame because popFrame adds a frame while single-stepping"
	self returnValueToParentFrame: value.
	self popStackFrame
]

{ #category : 'private' }
ScratchStackProcess >> applyTimedCommand [
	"Applies the current command to the already evaluated list of arguments over a particular time interval."

	| block arguments currentTime startTime args totalMSecs elapsedMSecs |
	block := stackFrame expression.
	arguments := stackFrame arguments.

	"Do we still need to evaluate more arguments?"
	arguments size < block argumentCount
		ifTrue: [ ^ self evaluateNextArgument ].
	arguments := block coerceArgs: arguments.

	"Record or get the time when command was first invoked."
	currentTime := Time millisecondClockValue.
	startTime := stackFrame startTime.
	startTime
		ifNil: [ "first call; just set starting time and value"
			args := arguments asArray , (Array with: 0 with: nil).
			stackFrame
				startValue: (block receiver perform: block selector withArguments: args).
			stackFrame startTime: currentTime.
			readyToYield := true.
			^ self ].

	"Call primitive time command with its arguments and the elapsed time in seconds"
	totalMSecs := arguments last * 1000.
	block selector = #mwait:elapsed:from:
		ifTrue: [ totalMSecs := arguments last ].
	elapsedMSecs := currentTime - startTime.
	currentTime < startTime
		ifTrue: [ elapsedMSecs := totalMSecs ].	"clock wrap"
	args := arguments asArray
		, (Array with: elapsedMSecs with: stackFrame startValue).
	block receiver perform: block selector withArguments: args.

	"If not done, then we leave stack as is and yield."
	elapsedMSecs < totalMSecs
		ifTrue: [ readyToYield := true.
			^ self ].

	"Pop this command off the stack and return."
	self popStackFrame
]

{ #category : 'special ops' }
ScratchStackProcess >> callSubroutine [
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
]

{ #category : 'special ops' }
ScratchStackProcess >> doAssert [
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
		ifTrue: [ ^ self ].

	self error: 'assertion failed'
]

{ #category : 'special ops' }
ScratchStackProcess >> doForever [
	"Executes one iteration of a forever loop."

	"Right now, the forever special form is at the top of the stack.  We're going to add two more things on top of this:  (1) a frame for evaluating the blocks in the forever block, and (2) a frame that just results in yielding control.  That way we'll evaluate the contents of the block, give up control, and do it all again."

	| blocks |
	"Remember blocks to evaluate before we clobber the stack."
	blocks := stackFrame expression firstBlockList.

	"When we're all done with these blocks, we want to yield."
	self pushStackFrame: (ScratchStackFrame new shouldYield: true).

	"First, we want to evaluate the blocks inside the loop."
	self pushStackFrame: (ScratchStackFrame new expression: blocks)
]

{ #category : 'special ops' }
ScratchStackProcess >> doIf [
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
]

{ #category : 'special ops' }
ScratchStackProcess >> doIfElse [
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
]

{ #category : 'special ops' }
ScratchStackProcess >> doIterate [
	"Handles one iteration of a repeat block."

	| arguments argExp block counter frame list |
	block := stackFrame expression.
	arguments := stackFrame arguments.

	"If we haven't done so yet, evaluate the argument to repeat."
	arguments isEmpty
		ifTrue: [ argExp := block argumentAt: 1.
			^ self pushStackFrame: (ScratchStackFrame new expression: argExp) ].

	arguments size = 1
		ifTrue: [ arguments := { 1 }, arguments ].

	"If the number of times to repeat is 0, then we're done."
	counter := arguments first asNumberNoError.
	list := arguments second.
	counter > list size
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
		addArgument: counter + 1;
		addArgument: list.

	block localVars
		withIndexDo: [ :each :index | frame localVarAt: each put: (list at: counter) ].

	self pushStackFrame: frame.

	"2.  yield."
	self pushStackFrame: (ScratchStackFrame new shouldYield: true).

	"1.  evaluate body of repeat block."
	self
		pushStackFrame: (ScratchStackFrame new expression: block firstBlockList)
]

{ #category : 'special ops' }
ScratchStackProcess >> doRepeat [
	"Handles one iteration of a repeat block."

	| arguments argExp block counter frame max |
	block := stackFrame expression.
	arguments := stackFrame arguments.

	"If we haven't done so yet, evaluate the argument to repeat."
	arguments isEmpty
		ifTrue: [ argExp := block argumentAt: 1.
			^ self pushStackFrame: (ScratchStackFrame new expression: argExp) ].

	arguments size = 1
		ifTrue: [ arguments := { 0 }, arguments ].

	"If the number of times to repeat is 0, then we're done."
	counter := arguments first asNumberNoError.
	max := arguments second asNumberNoError.
	counter >= max
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
		addArgument: counter + 1;
		addArgument: max.

	block localVars
		withIndexDo: [ :each :index | frame localVarAt: each put: counter ].

	self pushStackFrame: frame.

	"2.  yield."
	self pushStackFrame: (ScratchStackFrame new shouldYield: true).

	"1.  evaluate body of repeat block."
	self
		pushStackFrame: (ScratchStackFrame new expression: block firstBlockList)
]

{ #category : 'special ops' }
ScratchStackProcess >> doReturn [
	"Evaluates its argument, and returns the value to the frame from which the current method was called."

	| value args |
	args := stackFrame arguments.

	"Evaluate the argument, if necessary."
	args size < stackFrame expression argumentCount
		ifTrue: [ ^ self evaluateNextArgument ].

	"Remember the return value."
	value := args notEmpty
		ifTrue: [ args first ]
		ifFalse: [ nil ].

	"Pop until we're out of frames to pop, or we hit a return marker."
	[ stackFrame isNil ] whileFalse: [ self popStackFrame ].
	stackFrame
		ifNotNil: [ self returnValueToParentFrame: value.
			self popStackFrame ]
]

{ #category : 'special ops' }
ScratchStackProcess >> doUntil [
	"Evaluates the current until-loop expression."

	self doUntil: true
]

{ #category : 'special ops' }
ScratchStackProcess >> doUntil: terminatingBoolean [
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
]

{ #category : 'special ops' }
ScratchStackProcess >> doWhile [
	"Evaluates the current while-loop expression."

	self doUntil: false
]

{ #category : 'accessing' }
ScratchStackProcess >> errorFlag [
	^ errorFlag
]

{ #category : 'accessing' }
ScratchStackProcess >> errorFlag: anObject [
	errorFlag := anObject.
	stackFrame expression showError.
	stackFrame expression topBlock showErrorFeedback
]

{ #category : 'private' }
ScratchStackProcess >> evaluateCommandFor: anApplication [
	"Evaluates the current block. If the argument is non-nil, redraw the stage."

	| expression |
	expression := stackFrame expression.
	self class blockHighlightMSecs > 1
		ifTrue: [ expression litUp: true ].
	expression isSpecialForm
		ifTrue: [ ^ self evaluateSpecialForm ].

	"evaluate arguments, if necessary"
	stackFrame arguments size < expression argumentCount
		ifTrue: [ ^ self evaluateNextArgument ].
	expression isTimed
		ifTrue: [ ^ self applyTimedCommand ].
	self applyPrimitive
]

{ #category : 'private' }
ScratchStackProcess >> evaluateFor: anApplication [
	"Evaluates the current expression in the current environment for the given StageMorph."

	| expression |
	stackFrame shouldYield
		ifTrue: [ ^ self yield ].
	expression := stackFrame expression.
	stackFrame shouldUnlight
		ifTrue: [ expression litUp: false.
			^ self popStackFrame ].
	expression isCollection
		ifTrue: [ ^ self evaluateSequence ].
	expression isArgMorph
		ifTrue: [ ^ self evaluateSelfEvaluating ].
	expression isBlockMorph
		ifTrue: [ ^ self evaluateCommandFor: anApplication ].
	self error: 'Unknown expression type:  ' , expression printString
]

{ #category : 'private' }
ScratchStackProcess >> evaluateNextArgument [
	"Evaluates the next argument of the command in expression.  Requires that expression be a block that takes more args than are already evaluated in the current stack frame."

	| argumentExpression |
	argumentExpression := stackFrame expression
		argumentAt: stackFrame arguments size + 1.
	self
		pushStackFrame: (ScratchStackFrame new expression: argumentExpression)
]

{ #category : 'private' }
ScratchStackProcess >> evaluateSelfEvaluating [
	"The easiest case. Evaluate a number, color, or any self-evaluating expression."

	| value |
	value := stackFrame expression evaluate.
	self returnValueToParentFrame: value.
	self popStackFrame
]

{ #category : 'private' }
ScratchStackProcess >> evaluateSequence [
	"Requires that the current expression be a collection of blocks.  Evaluates the block in the current expression (which is a list of blocks) at the given pc."

	| blocks pc |
	blocks := stackFrame expression.
	pc := stackFrame pc.
	pc > blocks size
		ifTrue: [ self popStackFrame ]
		ifFalse: [ stackFrame pc: pc + 1.
			self
				pushStackFrame: (ScratchStackFrame new expression: (blocks at: pc)) ]
]

{ #category : 'private' }
ScratchStackProcess >> evaluateSpecialForm [
	"Evaluates the current special form expression.  Requires that no arguments have been evaluated, and that the current expression be a special form."

	self perform: stackFrame expression selector
]

{ #category : 'accessing' }
ScratchStackProcess >> expression: anObject [
	"Sets the expression to evaluate. This can be a single block or a collection of blocks. It should only be called before running the process."

	stackFrame ifNotNil: [ self error: 'Cannot modify expression' ].
	stackFrame := ScratchStackFrame new expression: anObject
]

{ #category : 'initialization' }
ScratchStackProcess >> initialize [

	readyToYield := false.
	errorFlag := false.
	readyToTerminate := false
]

{ #category : 'testing' }
ScratchStackProcess >> isRunning [
	"Answer true if I am still running, have not encountered an error, and don't refer to any deleted objects."

	^ stackFrame notNil and: [ errorFlag not ]
]

{ #category : 'api' }
ScratchStackProcess >> localVarAt: aString [
	^ stackFrame recursiveLocalVarAt: aString
]

{ #category : 'private' }
ScratchStackProcess >> popStackFrame [
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
]

{ #category : 'private' }
ScratchStackProcess >> popStackFrameNoUnhightlight [
	"Pops the current stack frame off the top of the stack, so that the next one becomes the current frame. Do not add a stack frame to unhighlight this block. Use this method when a block will re-evaluated, such 'wait until'."

	stackFrame := stackFrame parentFrame
]

{ #category : 'private' }
ScratchStackProcess >> pushStackFrame: aScratchStackFrame [
	"Pushes the given new stack frame onto the top of the stack, so that it becomes the current stack frame."

	aScratchStackFrame parentFrame: stackFrame.
	stackFrame := aScratchStackFrame
]

{ #category : 'private' }
ScratchStackProcess >> returnValueToParentFrame: anObject [
	"Append the given object to the argument list of my parent frame."

	| f |
	stackFrame ifNil: [ ^ self ].
	f := stackFrame parentFrame.
	[ f notNil and: [ f shouldUnlight ] ]
		whileTrue: [ f := f parentFrame ].
	f ifNotNil: [ f addArgument: anObject ]
]

{ #category : 'api' }
ScratchStackProcess >> runStepFor: anApplication [
	"Evaluates the current expression, then the next, etc., until the next yield."

	| expr |
	"evaluate blocks until we're ready to yield"
	readyToYield := false.
	[ readyToYield or: [ stackFrame isNil ] ]
		whileFalse: [ self evaluateFor: anApplication ].
	readyToTerminate
		ifTrue: [ "pop all stack frames, unlighting enclosing blocks:"
			[ stackFrame isNil ]
				whileFalse: [ expr := stackFrame expression.
					expr isBlockMorph
						ifTrue: [ expr litUp: false ].
					self popStackFrame ] ]
]

{ #category : 'private' }
ScratchStackProcess >> stackAsArray [
	"Returns an array describing the contents of the stack.  Useful for debugging."

	| frame collection |
	frame := stackFrame.
	collection := OrderedCollection new.
	[ frame isNil ]
		whileFalse: [ collection add: frame expression.
			frame := frame parentFrame ].
	^ collection asArray
]

{ #category : 'api' }
ScratchStackProcess >> stop [
	"Permanently terminates this process."

	readyToYield := true.
	readyToTerminate := true.
	topBlock ifNotNil: [ topBlock scratchProc: nil ]
]

{ #category : 'api' }
ScratchStackProcess >> stopAll [
	self doReturn.
	topBlock applicationDo: [ :app | app stopAllProcesses ]
]

{ #category : 'accessing' }
ScratchStackProcess >> topBlock [
	^ topBlock
]

{ #category : 'accessing' }
ScratchStackProcess >> topBlock: anObject [
	topBlock := anObject
]

{ #category : 'private' }
ScratchStackProcess >> yield [
	"Sets a flag indicating that we're ready to yield to another process."

	readyToYield := true.
	self popStackFrame
]
