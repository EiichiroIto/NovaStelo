test
testWindowsDocuments
	| d dir |
	d := self newDirectory.
	dir := d windowsDocuments.
	Smalltalk os isWindows
		ifTrue: [ self assert: dir isDirectory ]
		ifFalse: [ self assert: dir isNil ]