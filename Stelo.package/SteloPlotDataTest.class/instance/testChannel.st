test
testChannel
	| p |
	p := self newPlotData.
	self assert: p channel isNil.
	p channel: 1.
	self assert: p channel equals: 1.
	p channel: 2.
	self assert: p channel equals: 2