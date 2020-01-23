private
setDirectoryType: aSymbol
	| dir |
	dir := 	ScratchDirectory current perform: aSymbol.
	self setDirectory: dir