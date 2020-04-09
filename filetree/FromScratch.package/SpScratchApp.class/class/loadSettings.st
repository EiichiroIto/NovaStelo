accessing
loadSettings
	| fr dict |
	fr := FileSystem workingDirectory / self settingsFilename.
	fr isFile
		ifFalse: [ ^ self ].
	dict := STON fromString: fr contents.
	dict isDictionary
		ifFalse: [ ^ self ].
	Settings := dict