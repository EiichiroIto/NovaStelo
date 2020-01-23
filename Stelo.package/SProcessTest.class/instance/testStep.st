tests-accessing
testStep
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p privTransition: #idle.
	p step.