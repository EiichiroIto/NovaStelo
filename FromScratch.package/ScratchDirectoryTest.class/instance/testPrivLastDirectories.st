test
testPrivLastDirectories
	| d |
	d := self newDirectory.
	self assert: d privLastDirectories isDictionary.
	self assert: d privLastDirectories isEmpty