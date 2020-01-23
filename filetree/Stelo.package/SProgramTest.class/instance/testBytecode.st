test
testBytecode
	| p |
	p := SProgram new.
	self assert: p codes isEmpty.
	p privCodes: #(1 2 3).
	self assertCollection: p bytecode equals: #(1 2 3).
	p privCodes: #(1 2 div mod 3).
	self assertCollection: p bytecode equals: #(1 2 25 54 3).