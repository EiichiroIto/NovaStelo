test
testPens
	| p |
	p := self newPlotter.
	self assert: p pens isCollection.
	self assert: p pens size equals: 1.
	p plot: 2 data: 99.
	self assert: p pens size equals: 2