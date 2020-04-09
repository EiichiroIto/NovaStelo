test
testEvaluateFunctionWithArgs
	| s |
	s := self newScript.
	self assert: (s evaluateFunction: #yourself withArgs: #()) equals: s