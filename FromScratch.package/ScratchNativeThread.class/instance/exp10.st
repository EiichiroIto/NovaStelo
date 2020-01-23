arithmetic ops
exp10
	| x |
	x := self pop.
	self push: (10.0 raisedTo: x).