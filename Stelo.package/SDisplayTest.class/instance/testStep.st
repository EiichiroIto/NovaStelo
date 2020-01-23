test
testStep
	| d x |
	d := self newDisplay.
	d step.
	x := 0.
	d whenStepsDo: [ x := 1 ].
	self assert: x equals: 0.
	d step.
	self assert: x equals: 1