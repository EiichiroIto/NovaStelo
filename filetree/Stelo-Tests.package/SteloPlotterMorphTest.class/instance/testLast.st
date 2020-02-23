test
testLast
	| p |
	p := self newPlotter.
	self assert: p last isNil.
	p plot: 1 data: 99.
	self assert: (p last at: 1) equals: 99