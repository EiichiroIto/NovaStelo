tests-control ops
testReturn
	| e |
	e := self newThread.
	e pc: 20.
	e push: 30.
	e push: 10.
	e return.
	self assert: e pc equals: 30.
	self assert: e stack size equals: 0.
	self assert: e retVal equals: 10.