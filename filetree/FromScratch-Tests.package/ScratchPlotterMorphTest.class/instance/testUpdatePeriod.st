test
testUpdatePeriod
	| p |
	p := self newPlotter.
	self assert: p updatePeriod equals: 1000.
	p updatePeriod: 100.
	self assert: p updatePeriod equals: 100.
	p updatePeriod: 200.
	self assert: p updatePeriod equals: 200