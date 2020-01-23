code generator
generateEventHeader: aString
	self generateLineFeed.
	stream
		nextPutAll: '(when ';
		nextPutAll: aString.
	self generateLineFeed.
	stream nextPut: $(.