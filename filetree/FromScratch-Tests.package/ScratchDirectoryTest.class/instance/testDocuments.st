test
testDocuments
	| d |
	d := self newDirectory.
	self assert: (d documents isKindOf: FileReference)