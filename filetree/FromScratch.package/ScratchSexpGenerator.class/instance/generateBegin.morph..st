code generator
generateBegin: aSymbol morph: aMorph
	stream nextPut: $(.
	stream nextPutAll: aSymbol.
	aMorph blockArgs
		do: [ :each | 
			stream nextPut: Character space.
			stream nextPutAll: (each argString: parser) asString ].
	self generateLineFeed.
	stream nextPut: $(.