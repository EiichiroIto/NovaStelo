observer ops
nsum
	| v1 v2 |
	v2 := self pop.
	v1 := self pop.
	world patches nsum8: v1 to: v2.