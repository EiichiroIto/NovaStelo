test
testAuthor
	| p |
	p := self newProject.
	self assert: p author isEmpty.
	p author: 'abc'.
	self assert: p author equals: 'abc'