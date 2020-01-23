private
binaryCommand: aSymbol arg1: anObject1 arg2: anObject2
	self appendValue: anObject1.
	self appendValue: anObject2.
	self appendSymbol: aSymbol.
	^ nil