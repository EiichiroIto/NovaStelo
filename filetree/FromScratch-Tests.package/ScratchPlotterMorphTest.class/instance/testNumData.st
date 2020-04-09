test
testNumData
	| p |
	p := self newPlotter.
	self assert: p numData equals: 0.
	p addPlots: { ScratchPlot channel: 1 data: 1 }.
	p addPlots: { ScratchPlot channel: 1 data: 2 }.
	p addPlots: { ScratchPlot channel: 1 data: 3 }.
	self assert: p numData equals: 3