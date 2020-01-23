printing
printOn: aStream
	aStream
		nextPutAll: 'MicroWorld(';
		print: self identityHash;
		nextPut: $).