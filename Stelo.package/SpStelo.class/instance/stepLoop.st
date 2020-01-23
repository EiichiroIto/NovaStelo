button actions
stepLoop
	self stopAllProcesses.
	presenter stepTime: 0.
	self runLoop.
	self stepProcesses.
	self stopAllProcesses