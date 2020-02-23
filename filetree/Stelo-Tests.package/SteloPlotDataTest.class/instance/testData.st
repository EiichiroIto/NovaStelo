test
testData
	| p |
	p := self newPlotData.
	self assert: p data isNil.
	p data: 1.0.
	self assert: p data equals: 1.0.
	p data: 2.5.
	self assert: p data equals: 2.5