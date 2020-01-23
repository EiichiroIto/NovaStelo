accessing
getLastFolderForType: aSymbol
	| dir |
	dir := lastDirectories at: aSymbol ifAbsent: [ nil ].
	(dir notNil and: [ dir isDirectory ])
		ifTrue: [ ^ dir ].
	^ self getDefaultFolderForType: aSymbol