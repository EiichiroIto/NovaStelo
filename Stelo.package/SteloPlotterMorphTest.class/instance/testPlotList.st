test
testPlotList
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	p plot: 1 data: 20.
	p plot: 2 data: 30.
	p plot: 2 data: 40.
	self assertCollection: p data first equals: #(10).
	self assertCollection: p data second equals: #(20 30).
	self assertCollection: p data third equals: #(nil 40).
	self assertCollection: p last equals: #(nil 40).
	p plot: 2 list: #(2 3).
	self assertCollection: p data first equals: #(10 2).
	self assertCollection: p data second equals: #(20 3).
	self assertCollection: p data third equals: #(nil nil).
	self assertCollection: p last equals: #(nil nil).
	p plot: 1 list: #(5 6 7 8).
	self assertCollection: p data first equals: #(5 2).
	self assertCollection: p data second equals: #(6 3).
	self assertCollection: p data third equals: #(7 nil).
	self assertCollection: p data fourth equals: #(8 nil).
	self assertCollection: p last equals: #(8 nil)