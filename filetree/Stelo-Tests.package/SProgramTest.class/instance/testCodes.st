test
testCodes
	| p |
	p := SProgram new.
	self assert: p codes isEmpty.
	p privCodes: #(1 2 3).
	self assertCollection: p codes equals: #(1 2 3).
	p privCodes: #(4 5 6).
	self assertCollection: p codes equals: #(4 5 6).