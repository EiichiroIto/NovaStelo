api
stop
	"Permanently terminates this process."

	readyToYield := true.
	readyToTerminate := true.
	topBlock ifNotNil: [ topBlock scratchProc: nil ]