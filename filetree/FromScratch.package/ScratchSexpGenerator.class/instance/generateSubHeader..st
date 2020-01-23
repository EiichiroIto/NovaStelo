code generator
generateSubHeader: aString
	self generateLineFeed.
	stream
		nextPutAll: '(sub ';
		nextPutAll: aString.
	self generateLineFeed.
	stream nextPut: $(.