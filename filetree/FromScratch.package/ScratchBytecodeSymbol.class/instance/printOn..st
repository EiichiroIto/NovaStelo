printing
printOn: aStream
	aStream
		nextPutAll: '<symbol=';
		nextPutAll: selector asString;
		nextPut: $>.