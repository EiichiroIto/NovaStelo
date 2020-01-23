test
testStack
	| e |
	e := self newThread.
	self assert: e stack isCollection.
	self assert: e stack isEmpty.