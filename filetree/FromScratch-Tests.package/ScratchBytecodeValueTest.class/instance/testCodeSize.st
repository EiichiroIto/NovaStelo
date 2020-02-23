test
testCodeSize
	| c |
	c := self newValue: 0.
	self assert: c codeSize equals: 1.
	c := self newValue: 1.
	self assert: c codeSize equals: 1.
	c := self newValue: 2.
	self assert: c codeSize equals: 3.
	c := self newValue: 32767.
	self assert: c codeSize equals: 3.
	c := self newValue: -32768.
	self assert: c codeSize equals: 3.
	c := self newValue: 32768.
	self assert: c codeSize equals: 5.
	c := self newValue: -32769.
	self assert: c codeSize equals: 5.
	c := self newValue: 1.1.
	self assert: c codeSize equals: 5.