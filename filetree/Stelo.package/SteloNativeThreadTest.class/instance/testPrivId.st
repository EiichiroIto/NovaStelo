test
testPrivId
	| e |
	e := self newThread.
	self assert: e privId isNil.
	e privId: 10.
	self assert: e privId equals: 10.
	e privId: 20.
	self assert: e privId equals: 20.