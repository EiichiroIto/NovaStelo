test
testIsJump
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c isJump.