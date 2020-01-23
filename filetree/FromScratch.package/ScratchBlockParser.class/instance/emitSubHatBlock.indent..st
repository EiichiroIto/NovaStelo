code generator
emitSubHatBlock: aMorph indent: indent
	| str |
	str := aMorph subName.
	str isEmpty ifTrue: [^ self].
	codeGenerator generateSubHeader: str.
	aMorph nextBlock
		ifNotNil: [self
				emitCode: aMorph nextBlock
				indent: indent + (codeGenerator indentLevelFor: str)].
	codeGenerator generateSubFooter: str.