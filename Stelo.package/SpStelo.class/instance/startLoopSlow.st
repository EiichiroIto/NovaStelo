button actions
startLoopSlow
	self stopAllProcesses.
	presenter stepTime: 500.
	self runLoop