processes
stopAllProcesses
	process ifNil: [ ^ self ].
	process stop.
	process := nil