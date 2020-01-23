test
testPlottingDataAt
	| p ret |
	p := self newPlotter.
	p min: 5.
	p max: 10.
	p plot: 1 data: 5.
	p plot: 1 data: 10.
	p plot: 1 data: 7.5.
	p plot: 1 data: 0.
	p plot: 1 data: 15.
	p height: 35+100.
	self assert: p plottingBounds height equals: 100.
	ret := p plottingDataAt: 1.
	self assertCollection: ret equals: #(0).
	ret := p plottingDataAt: 2.
	self assertCollection: ret equals: #(100).
	ret := p plottingDataAt: 3.
	self assertCollection: ret equals: #(50).
	ret := p plottingDataAt: 4.
	self assertCollection: ret equals: #(0).
	ret := p plottingDataAt: 5.
	self assertCollection: ret equals: #(100).
	p plot: 2 data: 7.5.
	ret := p plottingDataAt: 5.
	self assertCollection: ret equals: #(100 50).
	ret := p plottingDataAt: 4.
	self assertCollection: ret equals: #(0 nil).
	p addPen: 3 color: Color black.
	ret := p plottingDataAt: 5.
	self assertCollection: ret equals: #(100 50 nil)