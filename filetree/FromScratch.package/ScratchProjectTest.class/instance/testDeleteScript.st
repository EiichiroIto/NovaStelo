test
testDeleteScript
	| p s1 s2 s3 |
	p := self newProject.
	self assert: p scripts isEmpty.
	s1 := self newScript.
	p addScript: s1.
	s2 := self newScript.
	p addScript: s2.
	s3 := self newScript.
	p addScript: s3.
	self assert: p scripts size equals: 3.
	p deleteScript: s2.
	self assert: p scripts size equals: 2.
	self assert: p scripts first equals: s1.
	self assert: p scripts second equals: s3