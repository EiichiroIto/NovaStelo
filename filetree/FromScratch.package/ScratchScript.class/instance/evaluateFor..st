evaluation
evaluateFor: aTopBlock
	| selector args |
	selector := aTopBlock selector.
	args := aTopBlock coerceArgs.
	^ selector isInfix
		ifTrue: [ self evaluateInfix: selector withArgs: args ]
		ifFalse: [ self evaluateFunction: selector withArgs: args ]