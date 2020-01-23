accessing
openFileNamed: aString
	self close.
	writer := GIFReadWriter on: aString asFileReference binaryWriteStream.
	writer ifNil: [ ^ self ].
	count := 0.