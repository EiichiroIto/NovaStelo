test
testUpdateCache
	| d |
	d := self newDisplay.
	self assert: d extent equals: 220 @ 220.
	self assert: d sworld extent equals: 100 @ 100.
	d updateCache.
	self assert: d cell equals: 2 @ 2.
	self assert: d offset equals: 10 @ 10.
	d extent: 150 @ 120.
	d updateCache.
	self assert: d cell equals: 1 @ 1.
	self assert: d offset equals: 25 @ 10.