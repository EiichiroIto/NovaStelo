test
testProgram
	| pr |
	pr := self newProcess.
	self assert: pr program isNil.
	pr program: 123.
	self assert: pr program equals: 123.