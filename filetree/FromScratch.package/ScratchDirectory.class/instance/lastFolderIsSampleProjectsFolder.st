accessing
lastFolderIsSampleProjectsFolder
	| lastDirPath sampleProjectDirPath |
	lastDirPath := (self getLastFolderForType: #project) pathString.
	sampleProjectDirPath := self examples pathString.
	^ lastDirPath beginsWith: sampleProjectDirPath