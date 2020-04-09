test
testEvaluateInfixWithArgs
	| s |
	s := self newScript.
	self assert: (s evaluateInfix: #= withArgs: #('true' true)).
	self assert: (s evaluateInfix: #= withArgs: #('false' false)).
	self assert: (s evaluateInfix: #= withArgs: #(true 'true')).
	self assert: (s evaluateInfix: #= withArgs: #(false 'false')).
	self deny: (s evaluateInfix: #= withArgs: #('true' false)).
	self deny: (s evaluateInfix: #= withArgs: #('false' true)).
	self deny: (s evaluateInfix: #= withArgs: #(false 'true')).
	self deny: (s evaluateInfix: #= withArgs: #(true 'false')).
	self assert: (s evaluateInfix: #< withArgs: #(1 2)).
	self deny: (s evaluateInfix: #< withArgs: #(1 1)).
	self assert: (s evaluateInfix: #< withArgs: #('3' '12')).
	self deny: (s evaluateInfix: #< withArgs: #('12' '12')).
	self assert: (s evaluateInfix: #< withArgs: #('a' 'b')).
	self deny: (s evaluateInfix: #< withArgs: #('a' 'a')).