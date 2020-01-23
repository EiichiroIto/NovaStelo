test
testIsCall
	| c |
	c := self newCall: 'abc'.
	self assert: c isCall.