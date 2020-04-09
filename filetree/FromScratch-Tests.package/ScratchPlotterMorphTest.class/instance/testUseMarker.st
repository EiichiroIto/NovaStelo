test
testUseMarker
	| p |
	p := self newPlotter.
	p width: 100.
	self assert: p useMarker.
	100 timesRepeat: [ p addPlots: {(ScratchPlot channel: 1 data: 1)} ].
	self deny: p useMarker