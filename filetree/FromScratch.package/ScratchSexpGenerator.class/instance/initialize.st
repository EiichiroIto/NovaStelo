initialization
initialize
	super initialize.
	parser := ScratchBlockParser codeGenerator: self.
	stream := WriteStream on: String new.
	indents := Array with: 0.
	indentLevel := 1.
	position := 0.
	wantsLinefeed := false