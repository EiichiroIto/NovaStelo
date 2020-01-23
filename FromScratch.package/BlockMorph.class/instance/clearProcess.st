processes
clearProcess
	"Called on the top block of a running stack when all processes are stopped."

	scratchProc ifNotNil: [self scratchProc: nil].
