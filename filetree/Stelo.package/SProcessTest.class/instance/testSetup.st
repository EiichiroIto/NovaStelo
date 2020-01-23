tests-accessing
testSetup
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p setup.
	self assert: p privTransition equals: #afterSetup.
	self assertCollection: p privRunningEvents equals: {EventId setupEventNo}.