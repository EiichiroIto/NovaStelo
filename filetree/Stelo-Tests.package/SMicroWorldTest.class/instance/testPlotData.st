test
testPlotData
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w plot: 1 data: 2.
	w plot: 3 data: 4.
	ret := w plotList.
	self assert: ret size equals: 2.
	self assertCollection: ret first channel equals: 1.
	self assertCollection: ret first data equals: 2.
	self assertCollection: ret second channel equals: 3.
	self assertCollection: ret second data equals: 4.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty