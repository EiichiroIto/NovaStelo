test
testPlotData
	| p |
	p := self newPlotter.
	self assert: p data isEmpty.
	self assert: p last isNil.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	self assert: p data size equals: 2.
	self assert: p data second equals: p last.
	self assert: p last first equals: 20.
	p plot: 2 data: 30.
	self assert: p data size equals: 2.
	self assert: p data second equals: p last.
	self assert: p last second equals: 30.
	p plot: 2 data: 40.
	self assert: p data size equals: 3.
	self assert: p data third equals: p last.
	self assert: p last second equals: 40