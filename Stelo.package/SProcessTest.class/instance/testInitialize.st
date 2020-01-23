tests
testInitialize
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p privTransition equals: #idle.