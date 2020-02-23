evaluation
evaluateWithArgs: rawArgs
	"Evalue this block with the given argument list."

	| args |
	"special case for math and boolean infix operators"
	selector isInfix
		ifTrue: [ ^ self evaluateInfixWithArgs: rawArgs ].
	args := self coerceArgs: rawArgs.

	"special case for unary operators"
	(#(abs not rounded sqrt truncated) includes: selector)
		ifTrue: [ ^ args first perform: selector ].
	^ receiver perform: selector withArguments: args