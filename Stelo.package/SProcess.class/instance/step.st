accessing
step
	self isRunning
		ifFalse: [ ^ self ].
	sworld
		clearRaisedEvents;
		incrementTicks.
	[ self doOneCycle ] whileTrue.
	self isRunning
		ifFalse: [ ^ self ].
	runningEvents := sworld raisedEvents copy.
	self perform: transition.