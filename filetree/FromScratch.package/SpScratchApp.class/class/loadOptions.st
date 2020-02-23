private
loadOptions
	| fr dict |
	fr := FileSystem workingDirectory / 'options.ston'.
	fr isFile
		ifFalse: [ ^ self ].
	dict := STON fromString: fr contents.
	dict isDictionary
		ifFalse: [ ^ self ].
	Options := dict