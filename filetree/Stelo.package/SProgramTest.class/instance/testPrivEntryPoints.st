tests-private
testPrivEntryPoints
	| p |
	p := SProgram new.
	self assert: p privEntryPoints isDictionary.
	self assert: p privEntryPoints isEmpty.