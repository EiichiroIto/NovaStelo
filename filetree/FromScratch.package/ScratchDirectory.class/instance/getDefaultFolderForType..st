accessing
getDefaultFolderForType: aSymbol
	(#(project export) includes: aSymbol)
		ifTrue: [ ^ self project ].
	^ self user