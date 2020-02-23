private
projectFor: aString
	| dir |
	aString ifNil: [ ^ FileSystem workingDirectory ].
	dir := self documents / aString.
	dir ensureCreateDirectory.
	dir isDirectory
		ifFalse: [ dir := FileSystem workingDirectory ].
	^ dir