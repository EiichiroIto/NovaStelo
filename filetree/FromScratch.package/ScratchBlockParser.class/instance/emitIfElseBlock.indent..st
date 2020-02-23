code generator
emitIfElseBlock: aMorph indent: indent 
	self emitBlockBegin: aMorph.
	aMorph trueBlock ifNil: [self emitPassIndent: indent + 1]
		ifNotNil: [self emitCode: aMorph trueBlock indent: indent + 1].
	self emitIndent: indent.
	self emitBlockCenter: aMorph.
	aMorph falseBlock ifNil: [self emitPassIndent: indent + 1]
		ifNotNil: [self emitCode: aMorph falseBlock indent: indent + 1].
	self emitBlockEnd: aMorph.