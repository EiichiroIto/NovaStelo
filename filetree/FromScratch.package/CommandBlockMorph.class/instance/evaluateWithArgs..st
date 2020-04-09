evaluation
evaluateWithArgs: rawArgs
	"Evalue this block with the given argument list."

	| args |
	^ selector isInfix
		ifTrue: [ self evaluateInfixWithArgs: rawArgs ]
		ifFalse: [ args := self coerceArgs: rawArgs.
			self evaluateFunctionWithArgs: args ]