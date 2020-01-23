printing
printOn: aStream
	aStream
		nextPutAll: 'SProgram(';
		nextPutAll: codes size asString;
		nextPut: $)