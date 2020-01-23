test
testCommand
	| p |
	p := self newPlotCommand.
	self assert: p command isNil.
	p command: 1.
	self assert: p command equals: 1.
	p command: 2.
	self assert: p command equals: 2