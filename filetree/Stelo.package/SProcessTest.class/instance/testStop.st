tests-execution
testStop
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p privTransition equals: #idle.
	self assert: p privRunningEvents isEmpty.