misc ops
dup
	| v |
	v := self pop.
	self push: v.
	self push: v.