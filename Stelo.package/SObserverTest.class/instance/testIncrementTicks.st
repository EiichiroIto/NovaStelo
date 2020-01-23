test
testIncrementTicks
	| o |
	o := SObserver new.
	self assert: o ticks equals: 0.
	o incrementTicks.
	self assert: o ticks equals: 1.
	o incrementTicks.
	self assert: o ticks equals: 2.