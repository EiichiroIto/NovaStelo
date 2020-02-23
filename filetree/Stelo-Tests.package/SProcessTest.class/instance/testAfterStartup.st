tests
testAfterStartup
	| p w |
	w := SMicroWorld new.
	p := w newProcess program: SProgram new.
	p privRunningEvents: #().
	p privTransition: #afterStartup.
	p afterStartup.
	self assert: p privTransition equals: #afterSetup.
	self assertCollection: p privRunningEvents equals: {EventId setupEventNo}.
	p privRunningEvents: #(8 9) asSet.
	p privTransition: #afterStartup.
	p afterStartup.
	self assert: p privTransition equals: #afterStartup.
	self assert: (p privRunningEvents isKindOf: Set).
	self assert: p privRunningEvents size equals: 2.
	self assert: (p privRunningEvents includes: 8).
	self assert: (p privRunningEvents includes: 9).