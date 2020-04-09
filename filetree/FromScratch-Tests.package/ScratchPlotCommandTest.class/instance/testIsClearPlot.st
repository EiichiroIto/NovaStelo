test
testIsClearPlot
	| p |
	p := self newPlotCommand.
	self deny: p isClearPlot.
	p command: p class clearPlotNo.
	self assert: p isClearPlot