accessing
saveSettings
	| fr stream |
	fr := FileSystem workingDirectory / self settingsFilename.
	fr isFile
		ifTrue: [ fr delete ].
	stream := fr writeStream.
	STON put: self settings onStream: stream.
	stream close