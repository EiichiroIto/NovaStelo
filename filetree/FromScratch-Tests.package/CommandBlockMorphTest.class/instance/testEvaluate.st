test
testEvaluate
	| b |
	b := self newBlock
		receiver: self newTestScript;
		yourself.
	b commandSpec: 'abs %n'.
	b selector: #abs.
	b argPermutation: #(1).
	b defaultArgs: #(-5).
	self assert: b evaluate equals: 5.
	b commandSpec: 'plus %n and %n'.
	b selector: #plus:and:.
	b argPermutation: #(1 2).
	b defaultArgs: #(3 4).
	self assert: b evaluate equals: 7