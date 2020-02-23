test
testIsRunning
	| c |
	c := SteloLibCall new.
	self deny: c isRunning.
