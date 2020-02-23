private
examples
	| dir |
	dir := FileSystem workingDirectory / 'Examples'.
	dir ensureCreateDirectory.
	^ dir