code generator
emitCode: aMorph indent: indent 
	self emitIndent: indent.
	aMorph emitCode: self indent: indent.
	aMorph nextBlock
		ifNotNil: [self
				emitCode: aMorph nextBlock
				indent: indent]