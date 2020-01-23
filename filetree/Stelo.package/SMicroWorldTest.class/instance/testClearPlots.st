test
testClearPlots
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w clearPlots.
	ret := w plotList.
	self assert: ret size equals: 1.
	self assert: ret first isClearPlot.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.