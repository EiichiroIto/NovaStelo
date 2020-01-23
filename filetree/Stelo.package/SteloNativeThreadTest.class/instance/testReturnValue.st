test
testReturnValue
	| e w c ret |
	w := self newWorld.
	w create: 3 turtles: 1.
	c := self sampleCode2.
	e := self newThread: w.
	e forBreedNo: 3 index: 1.
	e codes: c.
	ret := e evaluate: 9.
	self assert: ret equals: 9.
	self assert: e stack isEmpty.
	self assert: e pc equals: c size + 1.