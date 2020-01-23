tests-testing
testIsRunning
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p privTransition: #idle.
	self assert: p isRunning not.
	p privTransition: #loop.
	self assert: p isRunning.
	p privTransition: #setup.