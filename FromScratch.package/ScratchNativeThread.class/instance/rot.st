misc ops
rot
	| x1 x2 x3 |
	x1 := self pop.
	x2 := self pop.
	x3 := self pop.
	self push: x2.
	self push: x1.
	self push: x3