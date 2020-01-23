tests-private
testPrivRetVal
	| t |
	t := self newThread.
	self assert: t retVal equals: 0.
	t privRetVal: 123.
	self assert: t retVal equals: 123.