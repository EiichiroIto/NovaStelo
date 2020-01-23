test
testAddCode
	| p |
	p := SProgram new.
	self assert: p codes isEmpty.
	p addCode: #(1 2 3 4).
	self assertCollection: p codes equals: #(1 2 3 4).
	p addCode: #(5 6 7).
	self assertCollection: p codes equals: #(1 2 3 4 5 6 7).