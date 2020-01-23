arithmetic ops
plus
	| x y |
	y := self pop.
	x := self pop.
	self push: x + y.