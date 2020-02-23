tests-private
testPrivIsTerminated
	| t |
	t := self newThread.
	self assert: t isTerminated equals: false.
	t privIsTerminated: true.
	self assert: t isTerminated equals: true.
	t privIsTerminated: false.
	self assert: t isTerminated equals: false.