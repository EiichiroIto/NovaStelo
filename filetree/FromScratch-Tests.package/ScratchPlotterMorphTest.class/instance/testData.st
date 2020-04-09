test
testData
	| p |
	p := self newPlotter.
	self assert: p data isCollection.
	self assert: p data isEmpty.
	p plot: 1 data: 99.
	self assert: p data size equals: 1