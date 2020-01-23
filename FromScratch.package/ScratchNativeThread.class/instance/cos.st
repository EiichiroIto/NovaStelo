arithmetic ops
cos
	| x |
	x := self pop.
	self push: x degreesToRadians cos.