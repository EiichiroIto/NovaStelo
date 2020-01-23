test
testPrintOn
	| c |
	c := self newCall: 'abc'.
	self assert: c asString equals: '<call=abc,to=nil>'.
	c address: 2.
	self assert: c asString equals: '<call=abc,to=2>'.