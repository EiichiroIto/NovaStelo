test
testBroadcast
	| w e s |
	w := self newWorld.
	e := self newThread: w.
	s := e stack size.
	e push: 10.
	self assert: w raisedEvents isEmpty.
	e broadcast.
	self assert: e stack size equals: s.
	self assert: w raisedEvents size equals: 1.
	self assert: (w raisedEvents includes: 10).