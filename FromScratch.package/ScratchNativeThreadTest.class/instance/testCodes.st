tests-accessing
testCodes
	| t |
	t := self newThread.
	self assert: t codes isNil.
	t codes: #(1 2 3).
	self assertCollection: t codes equals: #(1 2 3).