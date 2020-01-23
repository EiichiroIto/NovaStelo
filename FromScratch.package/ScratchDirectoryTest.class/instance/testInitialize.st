test
testInitialize
	| d |
	d := self newDirectory.
	self assert: d appName isNil.
	self assert: d privLastDirectories isDictionary.
	self assert: d privLastDirectories isEmpty.
	self assert: d privHomeDirectory isNil