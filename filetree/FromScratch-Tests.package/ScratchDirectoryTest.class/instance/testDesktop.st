test
testDesktop
	| d |
	d := self newDirectory.
	self assert: (d desktop isKindOf: FileReference).
	self assert: d desktop isDirectory