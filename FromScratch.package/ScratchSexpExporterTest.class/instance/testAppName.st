test
testAppName
	| ex |
	ex := self newExporter.
	self assert: ex appName equals: self appName.
	ex appName: 'def'.
	self assert: ex appName equals: 'def'