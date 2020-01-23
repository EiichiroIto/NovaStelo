test
testLastFolderIsSampleProjectsFolder
	| d |
	d := self newDirectory.
	d
		setLastFolderTo: FileLocator documents asFileReference
		forType: #project.
	self deny: d lastFolderIsSampleProjectsFolder.
	d setLastFolderTo: d examples forType: #project.
	self assert: d lastFolderIsSampleProjectsFolder