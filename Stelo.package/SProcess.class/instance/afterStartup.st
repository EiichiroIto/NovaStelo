transitions
afterStartup
	runningEvents isEmpty
		ifTrue: [ self setup ]