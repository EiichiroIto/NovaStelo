test
testAddPlots
	| p |
	p := self newPlotter.
	p
		addPlots:
			{(ScratchPlot channel: 1 data: 2).
			(ScratchPlot channel: 1 data: 3)}.
	self assert: p data size equals: 2.
	self assertCollection: p data first equals: #(2).
	self assertCollection: p data second equals: #(3).
	p acceptPlots: false.
	p addPlots: {(ScratchPlot channel: 1 data: 2)}.
	self assert: p data size equals: 2