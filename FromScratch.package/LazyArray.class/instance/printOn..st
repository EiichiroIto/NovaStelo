printing
printOn: aStream
	aStream
		nextPutAll: 'LazyArray(';
		nextPutAll: className asString;
		nextPutAll: ','.
	self isFixed
		ifTrue: [ aStream nextPut: $* ].
	aStream
		nextPutAll: self size asString;
		nextPutAll: ')'.