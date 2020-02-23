test
testComment
	| p |
	p := self newProject.
	self assert: p comment isEmpty.
	p comment: 'abc'.
	self assert: p comment equals: 'abc'