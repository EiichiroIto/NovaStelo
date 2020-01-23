test
testExtent
	| d |
	d := self newDisplay.
	d updateCache.
	self deny: d forceModelChanged.
	d extent: 100 @ 100.
	self assert: d extent equals: 100 @ 100.
	self assert: d forceModelChanged