printing
printOn: aStream
	aStream
		nextPutAll: '<symbol=';
		nextPutAll: selector asString;
		nextPutAll: ',id=';
		nextPutAll: labelId asString;
		nextPutAll: ',jump=';
		nextPutAll: address asString;
		nextPut: $>.