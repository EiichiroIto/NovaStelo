code generator
emitCBlock: aMorph indent: indent 
	self emitBlockBegin: aMorph.
	aMorph nestedBlock ifNil: [self emitPassIndent: indent + 1]
		ifNotNil: [self emitCode: aMorph nestedBlock indent: indent + 1].
	self emitBlockEnd: aMorph.