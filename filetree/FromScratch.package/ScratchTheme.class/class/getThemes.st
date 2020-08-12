private
getThemes
	| response ref url |
	url := self themesURL.
	url ifNil: [ self error: 'ThemesURL is not set!' ].
	response := ZnEasy get: url.
	response isSuccess
		ifFalse: [ self error: 'Could not get Themes.zip!' ].
	ref := 'Themes.zip' asFileReference.
	ref binaryWriteStream
		nextPutAll: response contents;
		close.
	(ZipArchive new readFrom: ref fullName) extractAllTo: FileLocator workingDirectory.