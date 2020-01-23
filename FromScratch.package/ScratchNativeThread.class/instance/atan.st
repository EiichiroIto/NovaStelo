arithmetic ops
atan
	| x |
	x := self pop.
	self push: (x min: 1.0 max: -1.0) arcTan radiansToDegrees.