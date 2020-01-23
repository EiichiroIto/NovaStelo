test
testModified
	| p |
	p := self newProject.
	self assert: p modified.
	p modified: true.
	self assert: p modified.
	p modified: false.
	self deny: p modified