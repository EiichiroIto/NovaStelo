test
testWhenStepsDo
	| d x |
	d := self newDisplay.
	self assert: d whenStepsDo isNil.
	x := 0.
	d whenStepsDo: [ x := 3 ].
	self assert: d whenStepsDo isBlock.
	d step.
	self assert: x equals: 3