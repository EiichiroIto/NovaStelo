arithmetic ops
exp
	| x |
	x := self pop.
	self push: x exp.