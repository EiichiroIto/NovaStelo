test
testReplacePlotAtPut
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	p plot: 2 data: 30.
	p plot: 2 data: 40.
	self assert: p data first equals: #(10).
	self assert: p data second equals: #(20 30).
	self assert: p data third equals: #(nil 40).
	p replacePlot: 1 at: 2 put: 5.
	self assert: p data first equals: #(10).
	self assert: p data second equals: #(5 30).
	self assert: p data third equals: #(nil 40).
	p replacePlot: 2 at: 1 put: 6.
	self assert: p data first equals: #(10 6).
	self assert: p data second equals: #(5 30).
	self assert: p data third equals: #(nil 40).
	p replacePlot: 1 at: 3 put: 7.
	self assert: p data first equals: #(10 6).
	self assert: p data second equals: #(5 30).
	self assert: p data third equals: #(7 40)