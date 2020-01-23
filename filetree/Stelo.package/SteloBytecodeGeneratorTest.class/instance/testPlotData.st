test
testPlotData
	| w b t ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isCollection.
	self assert: ret isEmpty.
	b := self newGenerator.
	b plot: 1 data: 2.
	t := self newThread: w.
	t forObserver.
	t codes: b code.
	t execute: 1.
	ret := w plotList.
	self assert: ret size equals: 1.
	self assertCollection: ret first class equals: SteloPlotData.