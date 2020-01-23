tests-control ops
testCall
	| e |
	e := self newThread.
	e pc: 20.
	e push: 10.
	e call.
	self assert: e pc equals: 10.
	self assert: e stack size equals: 1.
	self assert: e pop equals: 20.