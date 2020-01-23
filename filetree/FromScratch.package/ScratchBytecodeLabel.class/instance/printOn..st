printing
printOn: aStream
	aStream
		nextPutAll: '<label=';
		nextPutAll: id asString;
		nextPut: $>.