accessing
putOn: aStream
	address ifNil: [ self error ].
	self putShort: address on: aStream.
	aStream nextPut: selector.