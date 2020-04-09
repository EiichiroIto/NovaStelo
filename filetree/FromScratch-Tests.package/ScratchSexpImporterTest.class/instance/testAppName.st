test
testAppName
	| i |
	i := self newImporter.
	self assert: i appName equals: 'test'.
	i appName: 'abc'.
	self assert: i appName equals: 'abc'