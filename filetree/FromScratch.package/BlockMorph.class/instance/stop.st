processes
stop
	scratchProc
		ifNotNil: [ self changed.
			scratchProc stop.
			scratchProc := nil ]