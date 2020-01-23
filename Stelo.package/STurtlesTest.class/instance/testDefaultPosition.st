tests-accessing
testDefaultPosition
	| ts |
	ts := STurtles new.
	self assert: ts defaultPosition equals: 0 @ 0.
	ts defaultPosition: 10 @ 20.
	self assert: ts defaultPosition equals: 10 @ 20.