api
runStepFor: anApplication
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