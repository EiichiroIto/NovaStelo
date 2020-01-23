private
appendSymbol: aSymbol
	stream nextPut: (ScratchBytecodeSymbol selector: aSymbol).