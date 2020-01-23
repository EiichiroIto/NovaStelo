code generator
generateCode: aSymbol morph: aBlockMorph
	stream nextPut: $(.
	stream nextPutAll: aSymbol.
	aBlockMorph blockArgs
		do: [ :each | 
			stream nextPut: Character space.
			stream nextPutAll: (each argString: parser) asString ].
	stream nextPut: $).
	self generateLineFeed.