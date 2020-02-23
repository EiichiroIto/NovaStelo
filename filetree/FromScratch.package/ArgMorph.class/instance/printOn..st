printing
printOn: aStream
	aStream
		nextPutAll: self class name;
		nextPut: $(;
		nextPutAll: (labelMorph ifNil: [ '' ] ifNotNil: [ labelMorph contents ]);
		nextPut: $)