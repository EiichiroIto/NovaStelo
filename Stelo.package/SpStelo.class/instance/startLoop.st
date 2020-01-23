button actions
startLoop
	self stopAllProcesses.
	presenter stepTime: 0.
	self runLoop