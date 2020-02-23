test
testEvaluateInfixWithArgs
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b selector: #=.
	self assert: (b evaluateInfixWithArgs: #('true' true)).
	self assert: (b evaluateInfixWithArgs: #('false' false)).
	self assert: (b evaluateInfixWithArgs: #(true 'true')).
	self assert: (b evaluateInfixWithArgs: #(false 'false')).
	self deny: (b evaluateInfixWithArgs: #('true' false)).
	self deny: (b evaluateInfixWithArgs: #('false' true)).
	self deny: (b evaluateInfixWithArgs: #(false 'true')).
	self deny: (b evaluateInfixWithArgs: #(true 'false')).
	b selector: #<.
	self assert: (b evaluateInfixWithArgs: #(1 2)).
	self deny: (b evaluateInfixWithArgs: #(1 1)).
	self assert: (b evaluateInfixWithArgs: #('3' '12')).
	self deny: (b evaluateInfixWithArgs: #('12' '12')).
	self assert: (b evaluateInfixWithArgs: #('a' 'b')).
	self deny: (b evaluateInfixWithArgs: #('a' 'a')).