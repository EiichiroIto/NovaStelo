arithmetic ops
not
	| x |
	x := self pop.
	self push: (x bitXor: 1).