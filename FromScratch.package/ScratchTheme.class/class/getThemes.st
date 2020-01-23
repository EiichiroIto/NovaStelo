private
getThemes
	| response ref |
	response := ZnEasy get: self themesURL.
	response isSuccess
		ifFalse: [ self error: 'Cannot get Themes.zip' ].
	ref := 'Themes.zip' asFileReference.
	ref binaryWriteStream
		nextPutAll: response contents;
		close.
	(ZipArchive new readFrom: ref fullName) extractAllTo: FileLocator workingDirectory.