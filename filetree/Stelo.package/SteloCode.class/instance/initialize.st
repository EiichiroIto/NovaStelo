initialization
initialize
	super initialize.
	parser := ScratchBlockParser codeGenerator: self.
	bcGenerator := SteloBytecodeGenerator new.