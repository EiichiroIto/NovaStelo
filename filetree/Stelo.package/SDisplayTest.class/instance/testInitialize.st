test
testInitialize
	| d |
	d := self newDisplay.
	self assert: d forceModelChanged.
	self assert: d info equals: ''.
	self assert: d stepTime equals: 1000