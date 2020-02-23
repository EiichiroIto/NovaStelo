test
testCode
	| b arr |
	b := self newGenerator.
	b plus: 1 and: 2.
	b minus: 3 with: 5.
	arr := b code.
	self
		assertCollection: arr
		equals: #(push1 pushShort 2 0 plus pushShort 3 0 pushShort 5 0 minus stop)