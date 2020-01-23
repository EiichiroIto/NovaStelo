test
testSwap
	| t |
	t := self newThread.
	t push: 1.
	t push: 2.
	t swap.
	self assert: t pop equals: 1.
	self assert: t pop equals: 2.