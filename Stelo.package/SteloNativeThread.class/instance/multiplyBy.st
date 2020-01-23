observer ops
multiplyBy
	| v p |
	p := self pop.
	v := self pop.
	world patches multiplyBy: p varNo: v.