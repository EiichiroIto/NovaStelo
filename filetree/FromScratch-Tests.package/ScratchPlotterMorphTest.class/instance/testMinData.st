test
testMinData
	| p |
	p := self newPlotter.
	p plot: 1 data: 10.
	self assert: p minData equals: 10.
	p plot: 2 data: 20.
	self assert: p minData equals: 10.
	p plot: 1 data: 30.
	self assert: p minData equals: 10.
	p plot: 2 data: 40.
	self assert: p minData equals: 10.
	p plot: 1 data: 5.
	self assert: p minData equals: 5.
	p plot: 2 data: 4.
	self assert: p minData equals: 4