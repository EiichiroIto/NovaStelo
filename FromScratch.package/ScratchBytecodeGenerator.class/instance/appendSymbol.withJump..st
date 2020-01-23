private
appendSymbol: aSymbol withJump: anInteger
	stream nextPut: (ScratchBytecodeSymbolWithJump selector: aSymbol labelId: anInteger).