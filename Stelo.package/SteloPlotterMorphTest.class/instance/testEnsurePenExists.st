test
testEnsurePenExists
	| p |
	p := self newPlotter.
	self assert: p pens size equals: 1.
	self assert: p pens first isColor.
	p ensurePenExists: 3.
	self assert: p pens size equals: 3.
	self assert: p pens first isColor.
	self assert: p pens second isNil.
	self assert: p pens third isColor.
	p plot: 1 data: 10.
	p ensurePenExists: 5.
	self assert: p last size equals: 5