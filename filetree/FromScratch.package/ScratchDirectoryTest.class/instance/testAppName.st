test
testAppName
	| d |
	d := self newDirectory.
	self assert: d appName isNil.
	d appName: 'abc'.
	self assert: d appName equals: 'abc'