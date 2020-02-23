test
testAsBlockTuple
	| b ret |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi'.
	ret := b asBlockTuple.
	self assertCollection: ret equals: #(#abc:def: 10 '').
	b argPermutation: #(1 2).
	(b argumentAt: 1) numExpression: 5.
	(b argumentAt: 2) stringExpression: 'a'.
	ret := b asBlockTuple.
	self assertCollection: ret equals: #(#abc:def: 5 'a')