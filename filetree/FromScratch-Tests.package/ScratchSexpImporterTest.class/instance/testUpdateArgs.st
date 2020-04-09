test
testUpdateArgs
	| i arr |
	i := self newImporter.
	arr := {'abc' . '123' . 'x'}.
	i updateArgs: arr.
	self assert: arr size equals: 3.
	self assert: arr first equals: #abc.
	self assert: arr second equals: 123.
	self assert: arr third equals: 'x'