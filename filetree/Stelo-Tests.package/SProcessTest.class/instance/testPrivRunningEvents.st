tests-private
testPrivRunningEvents
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p privRunningEvents isArray.
	self assert: p privRunningEvents isEmpty.
	p privRunningEvents: #(1 2 3).
	self assertCollection: p privRunningEvents equals: #(1 2 3).