test
testJump
	| t |
	t := self newThread.
	t codes: #(1 2 3).
	self assert: t pc equals: 1.
	t push: 5.
	self assert: t stack size equals: 1.
	t jump.
	self assert: t pc equals: 5.
	self assert: t stack size equals: 0.