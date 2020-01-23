test
testPrivPlotList
	| w ret |
	w := self newWorld.
	ret := w plotList.
	self assert: ret isEmpty.
	w privPlotList: #(1 2 3).
	ret := w plotList.
	self assertCollection: ret equals: #(1 2 3).
	ret := w plotList.
	self assert: ret isEmpty