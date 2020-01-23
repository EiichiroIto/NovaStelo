test
testNextAddress
	| p |
	p := SProgram new.
	self assert: p nextAddress equals: 1.
	p addCode: #(1 2 3 4).
	self assert: p nextAddress equals: 5.
	p addCode: #(5 6 7).
	self assert: p nextAddress equals: 8.