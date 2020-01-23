test
testComputer
	| d |
	d := self newDirectory.
	self assert: (d computer isKindOf: FileReference).
	self assert: d computer isDirectory