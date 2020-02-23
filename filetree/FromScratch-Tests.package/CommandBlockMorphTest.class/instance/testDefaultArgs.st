test
testDefaultArgs
	| b |
	b := self newBlock
		receiver: self newScript;
		yourself.
	b selector: #abc:def:.
	b commandSpec: 'abc %n def %s ghi'.
	b argPermutation: #(2 1).
	self assert: (b argumentAt: 1) evaluate equals: ''.
	self assert: (b argumentAt: 2) evaluate equals: 10.
	b defaultArgs: #('def').
	self assert: (b argumentAt: 1) evaluate equals: 'def'.
	self assert: (b argumentAt: 2) evaluate equals: 10.
	b defaultArgs: #('abc' 1).
	self assert: (b argumentAt: 1) evaluate equals: 'abc'.
	self assert: (b argumentAt: 2) evaluate equals: 1