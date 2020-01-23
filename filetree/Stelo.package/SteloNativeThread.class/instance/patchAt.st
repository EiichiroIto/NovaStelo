patch ops
patchAt
	| x y ret |
	y := self pop.
	x := self pop.
	ret := world patchIndexAtX: x y: y.
	self push: ret.