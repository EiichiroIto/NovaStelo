initialization
initialize
	super initialize.
	parser := ScratchBlockParser codeGenerator: self.
	stream := WriteStream on: String new.