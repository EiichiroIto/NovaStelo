test
testErrorOccuered
	| t |
	t := self newThread.
	self assert: t isTerminated equals: false.
	t errorOccuered.
	self assert: t isTerminated equals: true.