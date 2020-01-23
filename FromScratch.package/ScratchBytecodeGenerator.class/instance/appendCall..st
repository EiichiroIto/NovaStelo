private
appendCall: aString
	stream
		nextPut: (ScratchBytecodeCall subName: aString address: (self addressOfSubName: aString))