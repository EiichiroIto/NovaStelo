test
testNewData
	| p |
	p := self newPlotter.
	self assert: p last isNil.
	self assert: p data isEmpty.
	p newData.
	self assert: p last isArray.
	self assert: p data size equals: 1