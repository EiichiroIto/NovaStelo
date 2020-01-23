observer ops
diffuse
	| v p |
	p := self pop.
	v := self pop.
	world patches diffuse8: p varNo: v.