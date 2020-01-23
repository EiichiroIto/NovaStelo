test
testPrivStream
	| b |
	b := self newGenerator.
	self assert: b privStream isStream.
	self assert: b privStream contents isArray.