test
testReset
	| p |
	p := self newPlotter.
	p plot: 2 data: 99.
	self assert: (p last at: 2) equals: 99.
	self assert: p pens size equals: 2.
	self assert: p data size equals: 1.
	p min: 456.
	self assert: p min equals: 456.
	p max: 123.
	self assert: p max equals: 123.
	p reset.
	self assert: p pens isArray.
	self assert: p pens isEmpty.
	self assert: p data isCollection.
	self assert: p data isEmpty.
	self assert: p last isNil.
	self assert: p min isNil.
	self assert: p max isNil