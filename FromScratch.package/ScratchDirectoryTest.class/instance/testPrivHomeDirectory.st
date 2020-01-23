test
testPrivHomeDirectory
	| d x |
	d := self newDirectory.
	self assert: d privHomeDirectory isNil.
	x := FileSystem workingDirectory.
	d privHomeDirectory: x.
	self assert: d privHomeDirectory equals: x