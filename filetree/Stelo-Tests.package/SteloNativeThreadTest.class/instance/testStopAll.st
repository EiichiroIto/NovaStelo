test
testStopAll
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t stopAll.
	self deny: t isRunning.
	self assert: t isTerminated.