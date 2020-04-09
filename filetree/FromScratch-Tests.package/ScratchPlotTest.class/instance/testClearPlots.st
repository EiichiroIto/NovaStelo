test
testClearPlots
	| p |
	p := ScratchPlot clearPlots.
	self assert: p isClearPlot