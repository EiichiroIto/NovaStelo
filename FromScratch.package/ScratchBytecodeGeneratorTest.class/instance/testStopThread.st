test
testStopThread
	| g |
	g := self newGenerator.
	g stopThread.
	self assertCollection: g code equals: { #stop . #stop }