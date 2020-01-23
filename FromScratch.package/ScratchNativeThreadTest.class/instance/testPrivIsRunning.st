tests-testing
testPrivIsRunning
	| t |
	t := self newThread.
	self assert: t isRunning equals: false.
	t privIsRunning: true.
	self assert: t isRunning equals: true.
	t privIsRunning: false.
	self assert: t isRunning equals: false.