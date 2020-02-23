test
testUser
	| d u x |
	d := self newDirectory.
	u := d user.
	self assert: (u isKindOf: FileReference).
	x := FileSystem workingDirectory.
	d setHomeDir: x.
	self assert: d user equals: x