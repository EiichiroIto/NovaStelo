test
testPrintOn
	| c |
	c := self newValue: 123.
	self assert: c asString equals: '<value=123>'.