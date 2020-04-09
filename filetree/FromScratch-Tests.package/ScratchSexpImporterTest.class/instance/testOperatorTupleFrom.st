test
testOperatorTupleFrom
	| i arr |
	i := self newImporter.
	arr := {'plus:and:' . '123' . 'x'}.
	arr := i operatorTupleFrom: arr.
	self assert: arr size equals: 3.
	self assert: arr first equals: #+.
	self assert: arr second equals: 123.
	self assert: arr third equals: 'x'