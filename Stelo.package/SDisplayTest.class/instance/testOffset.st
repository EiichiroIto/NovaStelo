test
testOffset
	| d |
	d := self newDisplay.
	self assert: d offset isNil.
	d offset: 1 @ 2.
	self assert: d offset equals: 1 @ 2.
	d offset: 3 @ 4.
	self assert: d offset equals: 3 @ 4