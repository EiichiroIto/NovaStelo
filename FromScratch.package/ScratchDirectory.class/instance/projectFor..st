private
projectFor: aString
	| dir |
	aString ifNil: [ ^ FileSystem workingDirectory ].
	dir := self documents / aString.
	dir exists
		ifFalse: [ dir createDirectory ].
	dir isDirectory
		ifFalse: [ dir := FileSystem workingDirectory ].
	^ dir