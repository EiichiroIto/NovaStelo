accessing
printArgOn: aStream
	"Print this argument morph on the given stream."

	aStream nextPut: $".
	aStream nextPutAll: self labelMorph contents.
	aStream nextPut: $".
