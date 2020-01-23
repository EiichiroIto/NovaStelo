test
testPlotColor
	| w ret |
	w := self newWorld.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.
	w plot: 1 color: SColorList red.
	w plot: 3 color: SColorList blue.
	ret := w plotList.
	self assert: ret size equals: 2.
	self assertCollection: ret first channel equals: 1.
	self assertCollection: ret first color equals: Color red.
	self assertCollection: ret second channel equals: 3.
	self assertCollection: ret second color equals: Color blue.
	self assert: w plotList isCollection.
	self assert: w plotList isEmpty.