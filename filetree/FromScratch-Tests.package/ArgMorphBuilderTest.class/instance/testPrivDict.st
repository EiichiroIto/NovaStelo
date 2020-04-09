test
testPrivDict
	| b |
	b := self newBuilder.
	self assert: b privDict isDictionary.
	self assert: b privDict isEmpty