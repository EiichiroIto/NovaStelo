arithmetic ops
equal
	| x y |
	y := self pop.
	x := self pop.
	self push: (x closeTo: y).