test
testInitialize
	| p |
	p := self newProject.
	self assert: p info isDictionary.
	self assert: p scripts isArray.
	self assert: p modified