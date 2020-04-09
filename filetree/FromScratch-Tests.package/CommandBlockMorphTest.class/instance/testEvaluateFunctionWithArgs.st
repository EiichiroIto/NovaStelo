test
testEvaluateFunctionWithArgs
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs:.
	self assert: (b evaluateFunctionWithArgs: #(-5)) equals: 5.
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	self
		assert: (b evaluateFunctionWithArgs: #(1 2))
		equals: 3