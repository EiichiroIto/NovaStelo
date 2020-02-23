tests-control ops
testReturnValue
	| e c ret |
	c := self sampleCode2.
	e := self newThread.
	e codes: c.
	ret := e evaluate: 9.
	self assert: ret equals: 9.
	self assert: e stack isEmpty.
	self assert: e pc equals: c size + 1.