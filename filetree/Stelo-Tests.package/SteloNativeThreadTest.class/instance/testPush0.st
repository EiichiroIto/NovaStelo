test
testPush0
	| e |
	e := self newThread.
	self assert: e stack isEmpty.
	e push0.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(0).
	e push0.
	self assert: e stack size equals: 2.
	self assertCollection: e stack asArray equals: #(0 0).