test
testExamples
	| d |
	d := self newDirectory.
	self assert: (d examples isKindOf: FileReference).
	self assert: d examples isDirectory