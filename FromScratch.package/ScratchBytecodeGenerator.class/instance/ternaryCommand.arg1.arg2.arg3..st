private
ternaryCommand: aSymbol arg1: anObject1 arg2: anObject2 arg3: anObject3
	self appendValue: anObject1.
	self appendValue: anObject2.
	self appendValue: anObject3.
	self appendSymbol: aSymbol.
	^ nil