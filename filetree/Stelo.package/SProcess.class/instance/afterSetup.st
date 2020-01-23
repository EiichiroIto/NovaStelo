transitions
afterSetup
	runningEvents isEmpty
		ifTrue: [ self stop ]