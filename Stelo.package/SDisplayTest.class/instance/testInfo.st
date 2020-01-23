test
testInfo
	| d |
	d := self newDisplay.
	self assert: d info isEmpty.
	d info: 'abc'.
	self assert: d info equals: 'abc'