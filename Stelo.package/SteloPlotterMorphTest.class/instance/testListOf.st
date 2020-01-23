test
testListOf
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	p plot: 2 data: 30.
	p plot: 2 data: 40.
	self assertCollection: (p listOf: 1) equals: #(10 20).
	self assertCollection: (p listOf: 2) equals: #(30 40)