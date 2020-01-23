processes
hasRunningProcess

	^ scratchProc notNil and: [scratchProc isRunning]
