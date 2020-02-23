tests-accessing
testStartup
	| w p |
	w := SMicroWorld new.
	w addBreed: SObserver new.
	p := w newProcess program: SProgram new.
	p startup.
	self assert: p privTransition equals: #afterStartup.
	self assertCollection: p privRunningEvents equals: {EventId startupEventNo}.