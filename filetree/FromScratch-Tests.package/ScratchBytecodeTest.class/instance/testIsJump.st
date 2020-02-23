test
testIsJump
	| c |
	c := self newBytecode.
	self deny: c isJump.