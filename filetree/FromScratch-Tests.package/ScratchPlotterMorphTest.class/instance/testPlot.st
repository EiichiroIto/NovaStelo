test
testPlot
	| p d |
	p := self newPlotter.
	p plot: 1 data: 2.
	p plot: 1 data: 3.
	self deny: p data isEmpty.
	d := ScratchPlot clearPlots.
	p plot: d.
	self assert: p data isEmpty