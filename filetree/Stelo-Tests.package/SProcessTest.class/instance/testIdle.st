tests-execution
testIdle
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p idle.