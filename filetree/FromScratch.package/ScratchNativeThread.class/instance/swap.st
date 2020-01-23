misc ops
swap
	| x y |
	x := self pop.
	y := self pop.
	self push: x.
	self push: y.