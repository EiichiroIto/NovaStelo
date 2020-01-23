test
testPushFloat
	| e |
	e := self newThread.
	e codes: #(16r00 16r00 16rF6 16r42).
	self assert: e stack isEmpty.
	e pushFloat.
	self assert: e stack size equals: 1.
	self assertCollection: e stack asArray equals: #(123.0)