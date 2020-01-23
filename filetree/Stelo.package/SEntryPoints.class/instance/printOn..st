printing
printOn: aStream
	aStream nextPut: $(.
	self breedNoList
		do: [ :each | 
			aStream
				nextPutAll: each asString;
				nextPutAll: '->('.
			(self forBreedNo: each)
				do: [ :list | aStream nextPutAll: list asString ]
				separatedBy: [ aStream nextPut: Character space ].
			aStream nextPut: $) ]
		separatedBy: [ aStream nextPut: Character space ].
	aStream nextPut: $)