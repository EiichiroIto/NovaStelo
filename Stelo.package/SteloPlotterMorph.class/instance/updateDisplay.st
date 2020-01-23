accessing
updateDisplay
	((Time now asDuration - lastUpdateTime asDuration) totalSeconds < 1.0)
		ifTrue: [ ^ self ].
	lastUpdateTime := Time now.
	self
		updateCache;
		changed