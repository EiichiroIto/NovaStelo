test
testAddScript
	| p s |
	p := self newProject.
	self assert: p scripts isEmpty.
	s := self newScript.
	p addScript: s.
	self assert: p scripts size equals: 1.
	self assert: p scripts first equals: s.
	s := self newScript.
	p addScript: s.
	self assert: p scripts size equals: 2.
	self assert: p scripts second equals: s