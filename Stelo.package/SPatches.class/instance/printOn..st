printing
printOn: aStream
	aStream
		nextPutAll: 'Patches(';
		nextPutAll: order asString;
		nextPut: $x;
		nextPutAll: order asString;
		nextPut: $).