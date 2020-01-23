test
testPc
	| e |
	e := self newThread.
	self assert: e pc equals: 1.
	e pc: 10.
	self assert: e pc equals: 10.
	e pc: 20.
	self assert: e pc equals: 20.