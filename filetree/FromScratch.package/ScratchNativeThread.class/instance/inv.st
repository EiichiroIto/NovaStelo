arithmetic ops
inv
	| x |
	x := self pop.
	self push: (x bitXor: 16rFFFF).