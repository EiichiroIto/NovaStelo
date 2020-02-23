tests-command
testCreate
	| ts |
	ts := STurtles new breedNo: 3.
	self assert: ts countAlive equals: 0.
	ts create: 10.
	self assert: ts countAlive equals: 10.