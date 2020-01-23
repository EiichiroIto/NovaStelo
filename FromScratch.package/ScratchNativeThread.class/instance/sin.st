arithmetic ops
sin
	| x |
	x := self pop.
	self push: x degreesToRadians sin.