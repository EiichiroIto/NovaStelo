arithmetic ops
tan
	| x |
	x := self pop.
	self push: x degreesToRadians tan.