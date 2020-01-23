private
examples
	| dir |
	dir := FileSystem workingDirectory / 'Examples'.
	dir isDirectory
		ifFalse: [ dir := FileSystem workingDirectory ].
	^ dir