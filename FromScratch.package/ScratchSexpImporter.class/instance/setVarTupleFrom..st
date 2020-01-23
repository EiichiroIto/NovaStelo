private
setVarTupleFrom: aCollection
	| arg |
	arg := aCollection third.
	arg := self evaluateArg: arg.
	^ {#changeVariable.
	aCollection second.
	aCollection first asSymbol.
	arg}