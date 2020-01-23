tests-accessing
testSingle
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	p single.
	self assert: p privTransition equals: #afterSingle.
	self assertCollection: p privRunningEvents equals: {EventId singleEventNo}.