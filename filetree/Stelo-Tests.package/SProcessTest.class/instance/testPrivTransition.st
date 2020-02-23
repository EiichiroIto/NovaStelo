tests-private
testPrivTransition
	| p |
	p := SMicroWorld new newProcess program: SProgram new.
	self assert: p privTransition equals: #idle.
	p privTransition: #abc.
	self assert: p privTransition equals: #abc.