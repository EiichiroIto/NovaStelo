tests-execution
testDoOneCycle
	| e c |
	c := self sampleCode1.
	e := self newThread.
	e codes: c.
	self assert: e pc equals: 1.
	self assert: e stack isEmpty.
	self assert: e doOneCycle not.
	self assert: e pc equals: c size + 1.
	self assert: e stack size equals: 1.
	self assert: e stack first equals: 9.