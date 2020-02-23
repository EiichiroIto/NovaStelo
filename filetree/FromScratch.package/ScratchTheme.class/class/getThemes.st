private
getThemes
	| response ref url |
	url := self themesURL.
	url ifNil: [ self error: 'Need to set ThemesURL' ].
	response := ZnEasy get: url.
	response isSuccess
		ifFalse: [ self error: 'Cannot get Themes.zip' ].
	ref := 'Themes.zip' asFileReference.
	ref binaryWriteStream
		nextPutAll: response contents;
		close.
	(ZipArchive new readFrom: ref fullName) extractAllTo: FileLocator workingDirectory.