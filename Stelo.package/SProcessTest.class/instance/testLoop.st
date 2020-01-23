tests-accessing
testLoop
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p loop.
	self assert: p privTransition equals: #afterLoop.
	self assertCollection: p privRunningEvents equals: {EventId loopEventNo}.