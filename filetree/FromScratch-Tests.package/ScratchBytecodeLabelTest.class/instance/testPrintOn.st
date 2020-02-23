test
testPrintOn
	| c |
	c := self newLabel: 1.
	self assert: c asString equals: '<label=1>'.