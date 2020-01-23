printing
printOn: aStream
	aStream
		nextPutAll: 'Turtles(';
		nextPutAll: self countAlive asString;
		nextPut: $).