button actions
startSetup
	self stopAllProcesses.
	presenter stepTime: 0.
	self runSetup