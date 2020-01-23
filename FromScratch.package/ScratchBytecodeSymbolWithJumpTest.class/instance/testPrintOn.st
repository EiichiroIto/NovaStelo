test
testPrintOn
	| c |
	c := self newSymbol: #abc label: 1.
	self assert: c asString equals: '<symbol=abc,id=1,jump=nil>'.
	c address: 2.
	self assert: c asString equals: '<symbol=abc,id=1,jump=2>'.