tests-private
testPop
	| e |
	e := self newThread.
	e push: 10.
	e push: 20.
	self assertCollection: e stack asArray equals: #(10 20).
	self assert: e pop equals: 20.
	self assert: e pop equals: 10.
	self assert: e stack isEmpty.