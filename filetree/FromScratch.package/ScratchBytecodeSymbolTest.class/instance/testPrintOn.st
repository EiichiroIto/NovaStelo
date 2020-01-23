test
testPrintOn
	| c |
	c := self newSymbol: #abc.
	self assert: c asString equals: '<symbol=abc>'.