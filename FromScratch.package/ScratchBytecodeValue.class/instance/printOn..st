printing
printOn: aStream
	aStream
		nextPutAll: '<value=';
		nextPutAll: data asString;
		nextPut: $>.