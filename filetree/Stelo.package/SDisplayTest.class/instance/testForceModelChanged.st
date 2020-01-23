test
testForceModelChanged
	| d |
	d := self newDisplay.
	self assert: d forceModelChanged.
	d updateCache.
	self deny: d forceModelChanged