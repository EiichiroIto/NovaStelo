patch ops
xyOf
	| pno x y |
	pno := self pop.
	x := world patches xAt: pno.
	y := world patches yAt: pno.
	self push: x.
	self push: y.