test
testGetDefaultFolderForType
	| d |
	d := self newDirectory.
	self assert: (d getDefaultFolderForType: #project) equals: d project.
	self assert: (d getDefaultFolderForType: #export) equals: d project.
	self assert: (d getDefaultFolderForType: #test) equals: d user