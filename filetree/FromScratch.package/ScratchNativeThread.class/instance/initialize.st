initialization
initialize
	super initialize.
	stack := OrderedCollection new.
	pc := 1.
	isRunning := false.
	isTerminated := false.
	retVal := 0.