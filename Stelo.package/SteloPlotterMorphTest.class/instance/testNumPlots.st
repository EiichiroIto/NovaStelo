test
testNumPlots
	| p |
	p := self newPlotter.
	self assert: p numPlots equals: 1.
	p addPen: 2 color: Color red.
	self assert: p numPlots equals: 2.
	p addPen: 5 color: Color red.
	self assert: p numPlots equals: 5.
	p addPen: 3 color: Color red.
	self assert: p numPlots equals: 5