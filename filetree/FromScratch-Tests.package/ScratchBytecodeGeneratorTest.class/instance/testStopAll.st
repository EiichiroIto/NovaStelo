test
testStopAll
	| g |
	g := self newGenerator.
	g stopAll.
	self assertCollection: g code equals: { #stopAll . #stop }