private-writing
writeFileHeader
	"Write the file header on my stream."

	stream nextPutAll: 'ObjS' asByteArray.
	stream nextPut: 1.
	stream nextPutAll: 'Stch' asByteArray.
	stream nextPut: 1.
