test
testGetLastFolderForType
	| d x |
	d := self newDirectory.
	self assert: (d getLastFolderForType: #projects) equals: d user.
	self assert: (d getLastFolderForType: #user) equals: d user.
	x := FileSystem workingDirectory.
	d setLastFolderTo: x forType: #projects.
	self assert: (d getLastFolderForType: #projects) equals: x.
	self assert: (d getLastFolderForType: #user) equals: d user.