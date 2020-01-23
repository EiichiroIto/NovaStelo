test
testIsCall
	| c |
	c := ScratchBytecode basicNew.
	self deny: c isCall.