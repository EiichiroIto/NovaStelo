test
testWhenDoubleClickDo
	| d x |
	d := self newDisplay.
	self assert: d whenDoubleClickDo isNil.
	x := 0.
	d whenDoubleClickDo: [ x := 3 ].
	self assert: d whenDoubleClickDo isBlock